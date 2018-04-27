/** 
*  @?????? ???�?
 *  @�???? ??��?��??
 *  @??��?? 2008-6-21
 * 
 */

package common;

import java.io.Serializable;

public abstract class Entity implements Serializable {

	private static final long serialVersionUID = 1L;

	public Entity() {
		super();
		// TODO Auto-generated constructor stub
	}

	private String  id;

	

	public String  getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	/*public int hashCode() {
		final int PRIME = 31;
		int result = 1;
		result = PRIME * result + ((id == 0) ? 0 : id);
		return result;
	}*/

	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		final Entity other = (Entity) obj;
		return true;
	}

	public Entity(String  id) {
		super();
		this.id = id;
	}

}
