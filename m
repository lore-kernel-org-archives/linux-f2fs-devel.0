From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [RFC PATCH 8/8] f2fs-tools: remove unused list.h
Date: Tue, 31 Oct 2017 16:05:20 +0800
Message-ID: <f402770f-16e3-8065-a834-4b45a69d1877@huawei.com>
References: <20171031013824.46544-1-shengyong1@huawei.com>
 <20171031013824.46544-8-shengyong1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
 helo=mx.sourceforge.net)
 by sfs-ml-4.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <yuchao0@huawei.com>) id 1e9RYh-0001Wx-U4
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 31 Oct 2017 08:06:03 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191])
 by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
 (Exim 4.76) id 1e9RYb-00085E-U7
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 31 Oct 2017 08:06:03 +0000
In-Reply-To: <20171031013824.46544-8-shengyong1@huawei.com>
Content-Language: en-US
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Sheng Yong <shengyong1@huawei.com>, jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net

On 2017/10/31 9:38, Sheng Yong wrote:
> Commit 7d96d138a378 ("fsck.f2fs: remove list.h") has already the usage
> of list.h. So let's remove list.h itself.
> 
> Signed-off-by: Sheng Yong <shengyong1@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

> ---
>  include/list.h | 88 ----------------------------------------------------------
>  1 file changed, 88 deletions(-)
>  delete mode 100644 include/list.h
> 
> diff --git a/include/list.h b/include/list.h
> deleted file mode 100644
> index 571cd5c..0000000
> --- a/include/list.h
> +++ /dev/null
> @@ -1,88 +0,0 @@
> -
> -#define POISON_POINTER_DELTA 0
> -#define LIST_POISON1  ((void *) (0x00100100 + POISON_POINTER_DELTA))
> -#define LIST_POISON2  ((void *) (0x00200200 + POISON_POINTER_DELTA))
> -
> -#if !defined(offsetof)
> -#define offsetof(TYPE, MEMBER) ((size_t) &((TYPE *)0)->MEMBER)
> -#endif
> -#define container_of(ptr, type, member) ({                      \
> -		const typeof( ((type *)0)->member ) *__mptr = (ptr);    \
> -		(type *)( (char *)__mptr - offsetof(type,member) );})
> -
> -struct list_head {
> -	struct list_head *next, *prev;
> -};
> -
> -#define LIST_HEAD_INIT(name) { &(name), &(name) }
> -
> -#define LIST_HEAD(name) \
> -	struct list_head name = LIST_HEAD_INIT(name)
> -
> -static inline void INIT_LIST_HEAD(struct list_head *list)
> -{
> -	list->next = list;
> -	list->prev = list;
> -}
> -
> -static inline void __list_add(struct list_head *new,
> -		struct list_head *prev,
> -		struct list_head *next)
> -{
> -	next->prev = new;
> -	new->next = next;
> -	new->prev = prev;
> -	prev->next = new;
> -}
> -
> -static inline void list_add(struct list_head *new, struct list_head *head)
> -{
> -	__list_add(new, head, head->next);
> -}
> -
> -static inline void list_add_tail(struct list_head *new, struct list_head *head)
> -{
> -	__list_add(new, head->prev, head);
> -}
> -
> -static inline void __list_del(struct list_head * prev, struct list_head * next)
> -{
> -	next->prev = prev;
> -	prev->next = next;
> -}
> -
> -static inline void __list_del_entry(struct list_head *entry)
> -{
> -	__list_del(entry->prev, entry->next);
> -}
> -
> -static inline void list_del(struct list_head *entry)
> -{
> -	__list_del(entry->prev, entry->next);
> -	entry->next = LIST_POISON1;
> -	entry->prev = LIST_POISON2;
> -}
> -
> -static inline int list_empty(const struct list_head *head)
> -{
> -	return head->next == head;
> -}
> -
> -#define list_entry(ptr, type, member) \
> -	container_of(ptr, type, member)
> -
> -#define list_for_each(pos, head) \
> -	for (pos = (head)->next; pos != (head); pos = pos->next)
> -
> -#define list_for_each_safe(pos, n, head) \
> -	for (pos = (head)->next, n = pos->next; pos != (head); \
> -			pos = n, n = pos->next)
> -#define list_for_each_entry(pos, head, member)                          \
> -	for (pos = list_entry((head)->next, typeof(*pos), member);      \
> -			&pos->member != (head);    \
> -			pos = list_entry(pos->member.next, typeof(*pos), member))
> -#define list_for_each_entry_safe(pos, n, head, member)                  \
> -	for (pos = list_entry((head)->next, typeof(*pos), member),      \
> -			n = list_entry(pos->member.next, typeof(*pos), member); \
> -			&pos->member != (head);                                    \
> -			pos = n, n = list_entry(n->member.next, typeof(*n), member))
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
