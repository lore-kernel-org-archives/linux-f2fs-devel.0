From: Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] f2fs: use extra parenthesis around
 assignment/condition
Date: Tue, 17 Oct 2017 11:51:14 +0200
Message-ID: <20171017095114.GP9762@quack2.suse.cz>
References: <20171017090721.1393677-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
 helo=mx.sourceforge.net)
 by sfs-ml-1.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <jack@suse.cz>) id 1e4OWw-000496-Ru
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 17 Oct 2017 09:51:22 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
 (Exim 4.76) id 1e4OWv-0004Dg-G6
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 17 Oct 2017 09:51:22 +0000
Content-Disposition: inline
In-Reply-To: <20171017090721.1393677-1-arnd@arndb.de>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Arnd Bergmann <arnd@arndb.de>
Cc: Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org, Daniel Jordan <daniel.m.jordan@oracle.com>, Yunlei He <heyunlei@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linux-f2fs-devel@lists.sourceforge.net

On Tue 17-10-17 11:07:12, Arnd Bergmann wrote:
> gcc warns that writing a while() loop with an assignment as the condition
> looks suspiciously like a comparison, and suggests a workaround:
> 
> fs/f2fs/checkpoint.c: In function 'sync_meta_pages':
> fs/f2fs/checkpoint.c:321:9: error: suggest parentheses around assignment used as truth value [-Werror=parentheses]
>   while (nr_pages = pagevec_lookup_tag(&pvec, mapping, &index,
> 
> This seems reasonable, so let's do that.
> 
> Fixes: 4aba7297f4a5 ("f2fs: simplify page iteration loops")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> The warning is from mmotm. Andrew, please fold this fix into the
> patch that caused the warning, unless there are objections.

Yeah, thanks for fixing this.

								Honza

> ---
>  fs/f2fs/checkpoint.c |  4 ++--
>  fs/f2fs/node.c       | 16 ++++++++--------
>  2 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> index 3ed9dcbf70ae..6124f8710dc3 100644
> --- a/fs/f2fs/checkpoint.c
> +++ b/fs/f2fs/checkpoint.c
> @@ -318,8 +318,8 @@ long sync_meta_pages(struct f2fs_sb_info *sbi, enum page_type type,
>  
>  	blk_start_plug(&plug);
>  
> -	while (nr_pages = pagevec_lookup_tag(&pvec, mapping, &index,
> -				PAGECACHE_TAG_DIRTY)) {
> +	while ((nr_pages = pagevec_lookup_tag(&pvec, mapping, &index,
> +				PAGECACHE_TAG_DIRTY))) {
>  		int i;
>  
>  		for (i = 0; i < nr_pages; i++) {
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index d4ceb9ebfe92..d6e4df0bb622 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -1285,8 +1285,8 @@ static struct page *last_fsync_dnode(struct f2fs_sb_info *sbi, nid_t ino)
>  	pagevec_init(&pvec, 0);
>  	index = 0;
>  
> -	while (nr_pages = pagevec_lookup_tag(&pvec, NODE_MAPPING(sbi), &index,
> -				PAGECACHE_TAG_DIRTY)) {
> +	while ((nr_pages = pagevec_lookup_tag(&pvec, NODE_MAPPING(sbi), &index,
> +				PAGECACHE_TAG_DIRTY))) {
>  		int i;
>  
>  		for (i = 0; i < nr_pages; i++) {
> @@ -1439,8 +1439,8 @@ int fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
>  	pagevec_init(&pvec, 0);
>  	index = 0;
>  
> -	while (nr_pages = pagevec_lookup_tag(&pvec, NODE_MAPPING(sbi), &index,
> -				PAGECACHE_TAG_DIRTY)) {
> +	while ((nr_pages = pagevec_lookup_tag(&pvec, NODE_MAPPING(sbi), &index,
> +				PAGECACHE_TAG_DIRTY))) {
>  		int i;
>  
>  		for (i = 0; i < nr_pages; i++) {
> @@ -1552,8 +1552,8 @@ int sync_node_pages(struct f2fs_sb_info *sbi, struct writeback_control *wbc,
>  next_step:
>  	index = 0;
>  
> -	while (nr_pages = pagevec_lookup_tag(&pvec, NODE_MAPPING(sbi), &index,
> -				PAGECACHE_TAG_DIRTY)) {
> +	while ((nr_pages = pagevec_lookup_tag(&pvec, NODE_MAPPING(sbi), &index,
> +				PAGECACHE_TAG_DIRTY))) {
>  		int i;
>  
>  		for (i = 0; i < nr_pages; i++) {
> @@ -1650,8 +1650,8 @@ int wait_on_node_pages_writeback(struct f2fs_sb_info *sbi, nid_t ino)
>  
>  	pagevec_init(&pvec, 0);
>  
> -	while (nr_pages = pagevec_lookup_tag(&pvec, NODE_MAPPING(sbi), &index,
> -				PAGECACHE_TAG_WRITEBACK)) {
> +	while ((nr_pages = pagevec_lookup_tag(&pvec, NODE_MAPPING(sbi), &index,
> +				PAGECACHE_TAG_WRITEBACK))) {
>  		int i;
>  
>  		for (i = 0; i < nr_pages; i++) {
> -- 
> 2.9.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
