From: Changman Lee <cm224.lee@samsung.com>
Subject: Re: [PATCH 1/3] f2fs: call flush_dcache_page when the
	page	was updated
Date: Thu, 20 Nov 2014 15:04:10 +0900
Message-ID: <20141120060410.GB3117@lcm>
References: <1416436510-6251-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <cm224.lee@samsung.com>) id 1XrKs4-0006m6-MO
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 20 Nov 2014 06:05:36 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1XrKs2-0000ip-D9
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 20 Nov 2014 06:05:36 +0000
Received: from epcpsbgr3.samsung.com
	(u143.gpu120.samsung.co.kr [203.254.230.143])
	by mailout2.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0NFB00JUHQ925E70@mailout2.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Thu, 20 Nov 2014 15:05:26 +0900 (KST)
Content-disposition: inline
In-reply-to: <1416436510-6251-1-git-send-email-jaegeuk@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hi Jaegeuk,

We should call flush_dcache_page before kunmap because the purpose of the cache flush is to address aliasing problem related to virtual address.

On Wed, Nov 19, 2014 at 02:35:08PM -0800, Jaegeuk Kim wrote:
> Whenever f2fs updates mapped pages, it needs to call flush_dcache_page.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/dir.c    | 7 ++++++-
>  fs/f2fs/inline.c | 4 +++-
>  2 files changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
> index 5a49995..312fbfc 100644
> --- a/fs/f2fs/dir.c
> +++ b/fs/f2fs/dir.c
> @@ -287,8 +287,10 @@ void f2fs_set_link(struct inode *dir, struct f2fs_dir_entry *de,
>  	f2fs_wait_on_page_writeback(page, type);
>  	de->ino = cpu_to_le32(inode->i_ino);
>  	set_de_type(de, inode);
> -	if (!f2fs_has_inline_dentry(dir))
> +	if (!f2fs_has_inline_dentry(dir)) {
>  		kunmap(page);
> +		flush_dcache_page(page);
> +	}
>  	set_page_dirty(page);
>  	dir->i_mtime = dir->i_ctime = CURRENT_TIME;
>  	mark_inode_dirty(dir);
> @@ -366,6 +368,7 @@ static int make_empty_dir(struct inode *inode,
>  	do_make_empty_dir(inode, parent, &d);
>  
>  	kunmap_atomic(dentry_blk);
> +	flush_dcache_page(dentry_page);
>  
>  	set_page_dirty(dentry_page);
>  	f2fs_put_page(dentry_page, 1);
> @@ -579,6 +582,7 @@ fail:
>  		clear_inode_flag(F2FS_I(dir), FI_UPDATE_DIR);
>  	}
>  	kunmap(dentry_page);
> +	flush_dcache_page(dentry_page);
>  	f2fs_put_page(dentry_page, 1);
>  	return err;
>  }
> @@ -661,6 +665,7 @@ void f2fs_delete_entry(struct f2fs_dir_entry *dentry, struct page *page,
>  			NR_DENTRY_IN_BLOCK,
>  			0);
>  	kunmap(page); /* kunmap - pair of f2fs_find_entry */
> +	flush_dcache_page(page);
>  	set_page_dirty(page);
>  
>  	dir->i_ctime = dir->i_mtime = CURRENT_TIME;
> diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
> index f26fb87..8b7cc51 100644
> --- a/fs/f2fs/inline.c
> +++ b/fs/f2fs/inline.c
> @@ -45,8 +45,8 @@ void read_inline_data(struct page *page, struct page *ipage)
>  	src_addr = inline_data_addr(ipage);
>  	dst_addr = kmap_atomic(page);
>  	memcpy(dst_addr, src_addr, MAX_INLINE_DATA);
> -	flush_dcache_page(page);
>  	kunmap_atomic(dst_addr);
> +	flush_dcache_page(page);
>  	SetPageUptodate(page);
>  }
>  
> @@ -107,6 +107,7 @@ int f2fs_convert_inline_page(struct dnode_of_data *dn, struct page *page)
>  	dst_addr = kmap_atomic(page);
>  	memcpy(dst_addr, src_addr, MAX_INLINE_DATA);
>  	kunmap_atomic(dst_addr);
> +	flush_dcache_page(page);
>  	SetPageUptodate(page);
>  no_update:
>  	/* write data page to try to make data consistent */
> @@ -358,6 +359,7 @@ static int f2fs_convert_inline_dir(struct inode *dir, struct page *ipage,
>  					NR_INLINE_DENTRY * F2FS_SLOT_LEN);
>  
>  	kunmap_atomic(dentry_blk);
> +	flush_dcache_page(page);
>  	SetPageUptodate(page);
>  	set_page_dirty(page);
>  
> -- 
> 2.1.1
> 
> 
> ------------------------------------------------------------------------------
> Download BIRT iHub F-Type - The Free Enterprise-Grade BIRT Server
> from Actuate! Instantly Supercharge Your Business Reports and Dashboards
> with Interactivity, Sharing, Native Excel Exports, App Integration & more
> Get technology previously reserved for billion-dollar corporations, FREE
> http://pubads.g.doubleclick.net/gampad/clk?id=157005751&iu=/4140/ostg.clktrk
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

------------------------------------------------------------------------------
Download BIRT iHub F-Type - The Free Enterprise-Grade BIRT Server
from Actuate! Instantly Supercharge Your Business Reports and Dashboards
with Interactivity, Sharing, Native Excel Exports, App Integration & more
Get technology previously reserved for billion-dollar corporations, FREE
http://pubads.g.doubleclick.net/gampad/clk?id=157005751&iu=/4140/ostg.clktrk
