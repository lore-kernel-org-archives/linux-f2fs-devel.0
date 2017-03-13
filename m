From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 2/2] f2fs: avoid move encrypted block in
 BG_GC if it has been in memory
Date: Mon, 13 Mar 2017 11:30:05 -0700
Message-ID: <20170313183005.GB41055@jaegeuk.local>
References: <20170310095047.14540-1-heyunlei@huawei.com>
	<20170310095047.14540-2-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1cnUjZ-0002lj-SR
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 13 Mar 2017 18:30:17 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1cnUjY-0000G9-Rz
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 13 Mar 2017 18:30:17 +0000
Content-Disposition: inline
In-Reply-To: <20170310095047.14540-2-heyunlei@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Yunlei He <heyunlei@huawei.com>
Cc: linux-f2fs-devel@lists.sourceforge.net

On 03/10, Yunlei He wrote:
> If an encrypted block has been read to memory, we just dirty it
> and return directly.
> 
> Signed-off-by: Yunlei He <heyunlei@huawei.com>
> ---
>  fs/f2fs/gc.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index 418fd98..ca94518 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -564,7 +564,7 @@ static bool is_alive(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
>  }
>  
>  static void move_encrypted_block(struct inode *inode, block_t bidx,
> -							unsigned int segno, int off)
> +					int gc_type, unsigned int segno, int off)
>  {
>  	struct f2fs_io_info fio = {
>  		.sbi = F2FS_I_SB(inode),
> @@ -607,6 +607,12 @@ static void move_encrypted_block(struct inode *inode, block_t bidx,
>  	 */
>  	f2fs_wait_on_page_writeback(page, DATA, true);
>  
> +	if (gc_type == BG_GC && PageUptodate(page) &&
> +				fscrypt_has_encryption_key(inode)) {

Why do we need the encryption key?

Thanks,

> +		set_page_dirty(page);
> +		goto put_out;
> +	}
> +
>  	get_node_info(fio.sbi, dn.nid, &ni);
>  	set_summary(&sum, dn.nid, dn.ofs_in_node, ni.version);
>  
> @@ -827,7 +833,8 @@ static void gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
>  			start_bidx = start_bidx_of_node(nofs, inode)
>  								+ ofs_in_node;
>  			if (f2fs_encrypted_inode(inode) && S_ISREG(inode->i_mode))
> -				move_encrypted_block(inode, start_bidx, segno, off);
> +				move_encrypted_block(inode, start_bidx,
> +								gc_type, segno, off);
>  			else
>  				move_data_page(inode, start_bidx, gc_type, segno, off);
>  
> -- 
> 2.10.1
> 
> 
> ------------------------------------------------------------------------------
> Announcing the Oxford Dictionaries API! The API offers world-renowned
> dictionary content that is easy and intuitive to access. Sign up for an
> account today to start using our lexical data to power your apps and
> projects. Get started today and enter our developer competition.
> http://sdm.link/oxford
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
