package bookstore.database;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.TableGenerator;

@Entity
@TableGenerator(name = "authorPKgenerator", pkColumnName = "SEQUENCE_AUTHOR", pkColumnValue = "PKAuthor")
public class Author implements Serializable {
	private static final long serialVersionUID = -1613645588949060688L;
	@Id
	@GeneratedValue(generator="authorPKgenerator", strategy=GenerationType.TABLE)
	private long id;
	@Column(name="FIRST_NAME")
	private String firstName;
	private String lastName;
	private Date birthDate;
	private Collection<Book> books;
	
	public Author() {
	}
	
	public Author(String firstName, String lastName, Date birthDate) {
		this.firstName = firstName;
		this.lastName = lastName;
		this.birthDate = birthDate;
	}

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public void setFirstName(String param) {
		this.firstName = param;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setLastName(String param) {
		this.lastName = param;
	}

	public String getLastName() {
		return lastName;
	}

	public void setBirthDate(Date param) {
		this.birthDate = param;
	}

	public Date getBirthDate() {
		return birthDate;
	}

	public Collection<Book> getBooks() {
		return books;
	}

	public void setBooks(Collection<Book> books) {
		this.books = books;
	}
	
	public void addBook(Book book) {
		if (books == null) {
			books = new ArrayList<Book>();
		}
		books.add(book);
	}

}