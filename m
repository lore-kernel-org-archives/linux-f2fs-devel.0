From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 2/7] f2fs: do in batches truncation in truncate_hole
Date: Wed, 16 Sep 2015 11:01:12 -0700
Message-ID: <20150916180112.GB99097@jaegeuk-mac02.mot.com>
References: <00f201d0ec5c$8274e670$875eb350$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <00f201d0ec5c$8274e670$875eb350$@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <chao2.yu@samsung.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Chao,

How about changing the original patch slightly like below?

 o don't have to use index variable
 o should not skip the entire dnode indices, when one of them is -ENOENT

---
 fs/f2fs/file.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 180b838..e8536a8 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -739,33 +739,32 @@ static int fill_zero(struct inode *inode, pgoff_t index,
 
 int truncate_hole(struct inode *inode, pgoff_t pg_start, pgoff_t pg_end)
 {
-	pgoff_t count, index = pg_start;
+	pgoff_t count;
 	int err;
 
-	while (index < pg_end) {
+	while (pg_start < pg_end) {
 		struct dnode_of_data dn;
 		pgoff_t end_offset;
 
 		set_new_dnode(&dn, inode, NULL, NULL, 0);
-		err = get_dnode_of_data(&dn, index, LOOKUP_NODE);
+		err = get_dnode_of_data(&dn, pg_start, LOOKUP_NODE);
 		if (err) {
 			if (err == -ENOENT) {
-				index = PGOFS_OF_NEXT_DNODE(index,
-							F2FS_I(inode));
+				pg_start++;
 				continue;
 			}
 			return err;
 		}
 
 		end_offset = ADDRS_PER_PAGE(dn.node_page, F2FS_I(inode));
-		count = min(end_offset - dn.ofs_in_node, pg_end - index);
+		count = min(end_offset - dn.ofs_in_node, pg_end - pg_start);
 
 		f2fs_bug_on(F2FS_I_SB(inode), count == 0 || count > end_offset);
 
 		truncate_data_blocks_range(&dn, count);
 		f2fs_put_dnode(&dn);
 
-		index += count;
+		pg_start += count;
 	}
 	return 0;
 }
-- 
2.1.1

On Fri, Sep 11, 2015 at 02:38:05PM +0800, Chao Yu wrote:
> truncate_data_blocks_range can do in batches truncation which makes all
> changes in dnode page content, dnode page status, extent cache, block
> count updating together.
> 
> But previously, truncate_hole() always truncates one block in dnode page
> at a time by invoking truncate_data_blocks_range(,1), which make thing
> slow.
> 
> This patch changes truncate_hole() to do in batches truncation for all
> target blocks in one direct node inside truncate_data_blocks_range, which
> can make our punch hole operation in ->fallocate more efficent.
> 
> Signed-off-by: Chao Yu <chao2.yu@samsung.com>
> ---
>  fs/f2fs/file.c | 20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index b2fab9e..ac97f78 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -738,23 +738,33 @@ static int fill_zero(struct inode *inode, pgoff_t index,
>  
>  int truncate_hole(struct inode *inode, pgoff_t pg_start, pgoff_t pg_end)
>  {
> -	pgoff_t index;
> +	pgoff_t count, index = pg_start;
>  	int err;
>  
> -	for (index = pg_start; index < pg_end; index++) {
> +	while (index < pg_end) {
>  		struct dnode_of_data dn;
> +		pgoff_t end_offset;
>  
>  		set_new_dnode(&dn, inode, NULL, NULL, 0);
>  		err = get_dnode_of_data(&dn, index, LOOKUP_NODE);
>  		if (err) {
> -			if (err == -ENOENT)
> +			if (err == -ENOENT) {
> +				index = PGOFS_OF_NEXT_DNODE(index,
> +							F2FS_I(inode));
>  				continue;
> +			}
>  			return err;
>  		}
>  
> -		if (dn.data_blkaddr != NULL_ADDR)
> -			truncate_data_blocks_range(&dn, 1);
> +		end_offset = ADDRS_PER_PAGE(dn.node_page, F2FS_I(inode));
> +		count = min(end_offset - dn.ofs_in_node, pg_end - index);
> +
> +		f2fs_bug_on(F2FS_I_SB(inode), count == 0 || count > end_offset);
> +
> +		truncate_data_blocks_range(&dn, count);
>  		f2fs_put_dnode(&dn);
> +
> +		index += count;
>  	}
>  	return 0;
>  }
> -- 
> 2.4.2
