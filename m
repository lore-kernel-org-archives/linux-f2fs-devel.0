From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 2/2] f2fs: invalidate xattr node page when
 evict inode
Date: Sat, 2 Aug 2014 07:42:23 -0700
Message-ID: <20140802144223.GA1094@jaegeuk-mac02.hsd1.ca.comcast.net>
References: <017301cfacc1$4b476730$e1d63590$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1XDaVU-0002F9-W7
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 02 Aug 2014 14:42:01 +0000
Received: from mail.kernel.org ([198.145.19.201])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XDaVT-0007Xb-5m for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 02 Aug 2014 14:42:00 +0000
Content-Disposition: inline
In-Reply-To: <017301cfacc1$4b476730$e1d63590$@samsung.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <chao2.yu@samsung.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hi Chao,

On Thu, Jul 31, 2014 at 09:13:11PM +0800, Chao Yu wrote:
> When inode is evicted, all the page cache belong to this inode should be
> released including the xattr node page. But previously we didn't do this, this
> patch fixed this issue.
> 
> Signed-off-by: Chao Yu <chao2.yu@samsung.com>
> ---
>  fs/f2fs/inode.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
> index 0e69aa9..8a5403b 100644
> --- a/fs/f2fs/inode.c
> +++ b/fs/f2fs/inode.c
> @@ -267,10 +267,16 @@ int f2fs_write_inode(struct inode *inode, struct writeback_control *wbc)
>  void f2fs_evict_inode(struct inode *inode)
>  {
>  	struct f2fs_sb_info *sbi = F2FS_SB(inode->i_sb);
> +	struct f2fs_inode_info *fi = F2FS_I(inode);
>  
>  	trace_f2fs_evict_inode(inode);
> +
>  	truncate_inode_pages_final(&inode->i_data);
>  
> +	if (fi->i_xattr_nid)
> +		invalidate_mapping_pages(NODE_MAPPING(sbi),
> +					fi->i_xattr_nid, fi->i_xattr_nid);

It would be good to place this below with invalidate_mapping_paages(ino).
Since, in the case of deletion, we need to get the xattr node page again
on the remove_inode_page call path.

Thanks,

> +
>  	if (inode->i_ino == F2FS_NODE_INO(sbi) ||
>  			inode->i_ino == F2FS_META_INO(sbi))
>  		goto out_clear;
> -- 
> 2.0.1.474.g72c7794

------------------------------------------------------------------------------
Want fast and easy access to all the code in your enterprise? Index and
search up to 200,000 lines of code with a free copy of Black Duck
Code Sight - the same software that powers the world's largest code
search on Ohloh, the Black Duck Open Hub! Try it now.
http://p.sf.net/sfu/bds
