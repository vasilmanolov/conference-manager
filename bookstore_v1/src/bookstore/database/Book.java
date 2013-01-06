package bookstore.database;

import java.io.Serializable;

public class Book implements Serializable {
	private static final long serialVersionUID = -7846215096792524127L;
	private long bookId;
    private String description;
    private String title;
    private boolean onSale;
    private float price;
    private int calendar_year;
    private int inventory;
	private Author author;

    public Book() {
    }

    public Book(Author author, String title, float price, boolean onSale, int calendar_year, String description, int inventory) {
    	this.author = author;
        this.title = title;
        this.price = price;
        this.onSale = onSale;
        this.calendar_year = calendar_year;
        this.description = description;
        this.inventory = inventory;
        this.author.addBook(this);
    }

    public long getBookId() {
        return this.bookId;
    }

    public String getTitle() {
        return this.title;
    }

    public float getPrice() {
        return this.price;
    }

    public boolean getOnSale() {
        return this.onSale;
    }

    public int getCalendar_year() {
        return this.calendar_year;
    }

    public String getDescription() {
        return this.description;
    }

    public int getInventory() {
        return this.inventory;
    }

    public void setBookId(long id) {
        this.bookId = id;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public void setPrice(float price) {
        this.price = price;
    }

    public void setOnSale(boolean onSale) {
        this.onSale = onSale;
    }

    public void setCalendar_year(int calendar_year) {
        this.calendar_year = calendar_year;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public void setInventory(int inventory) {
        this.inventory = inventory;
    }

	public Author getAuthor() {
		return author;
	}

	public void setAuthor(Author author) {
		this.author = author;
	}
}
