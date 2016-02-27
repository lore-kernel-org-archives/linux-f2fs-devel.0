From: Chao Yu <chao@kernel.org>
Subject: Re: [f2fs-dev] [PATCH v2] f2fs crypto: fix incorrect positioning for
 GCing encrypted data page
Date: Sat, 27 Feb 2016 09:01:04 +0800
Message-ID: <56D0F550.8040403@kernel.org>
References: <009801d16e20$08659960$1930cc20$@samsung.com>
 <20160226195044.GA54334@jaegeuk.gateway>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160226195044.GA54334@jaegeuk.gateway>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao2.yu@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Jaegeuk,

On 2016/2/27 3:50, Jaegeuk Kim wrote:
> Hi Chao,
> 
> On Tue, Feb 23, 2016 at 05:52:43PM +0800, Chao Yu wrote:
>> For now, flow of GCing an encrypted data page:
>> 1) try to grab meta page in meta inode's mapping with index of old block
>> address of that data page
>> 2) load data of ciphertext into meta page
>> 3) allocate new block address
>> 4) write the meta page into new block address
>> 5) update block address pointer in direct node page.
>>
>> Other reader/writer will use f2fs_wait_on_encrypted_page_writeback to
>> check and wait on GCed encrypted data cached in meta page writebacked
>> in order to avoid inconsistence among data page cache, meta page cache
>> and data on-disk when updating.
>>
>> However, we will use new block address updated in step 5) as an index to
>> lookup meta page in inner bio buffer. That would be wrong, and we will
>> never find the GCing meta page, since we use the old block address as
>> index of that page in step 1).
>>
>> This patch fixes the issue by adjust the order of step 1) and step 3),
>> and in step 1) grab page with index generated in step 3).
>>
>> Signed-off-by: Chao Yu <chao2.yu@samsung.com>
>> ---
>>  v2:
>>  - fix to recover data page to old block address when error occurs.
>>
>>  fs/f2fs/f2fs.h    |  2 ++
>>  fs/f2fs/gc.c      | 25 +++++++++++++++++--------
>>  fs/f2fs/segment.c |  3 +--
>>  3 files changed, 20 insertions(+), 10 deletions(-)
>>
>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>> index b57dee6..a7197b3 100644
>> --- a/fs/f2fs/f2fs.h
>> +++ b/fs/f2fs/f2fs.h
>> @@ -1821,6 +1821,8 @@ void write_meta_page(struct f2fs_sb_info *, struct page *);
>>  void write_node_page(unsigned int, struct f2fs_io_info *);
>>  void write_data_page(struct dnode_of_data *, struct f2fs_io_info *);
>>  void rewrite_data_page(struct f2fs_io_info *);
>> +void __f2fs_replace_block(struct f2fs_sb_info *, struct f2fs_summary *,
>> +					block_t, block_t, bool, bool);
>>  void f2fs_replace_block(struct f2fs_sb_info *, struct dnode_of_data *,
>>  				block_t, block_t, unsigned char, bool, bool);
>>  void allocate_data_block(struct f2fs_sb_info *, struct page *,
>> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
>> index 4af3d80..c7cb1e6 100644
>> --- a/fs/f2fs/gc.c
>> +++ b/fs/f2fs/gc.c
>> @@ -549,6 +549,7 @@ static void move_encrypted_block(struct inode *inode, block_t bidx)
>>  	struct f2fs_summary sum;
>>  	struct node_info ni;
>>  	struct page *page;
>> +	block_t newaddr;
>>  	int err;
>>  
>>  	/* do not read out */
>> @@ -579,12 +580,15 @@ static void move_encrypted_block(struct inode *inode, block_t bidx)
>>  	fio.page = page;
>>  	fio.new_blkaddr = fio.old_blkaddr = dn.data_blkaddr;
>>  
>> -	fio.encrypted_page = pagecache_get_page(META_MAPPING(fio.sbi),
>> -					fio.new_blkaddr,
>> -					FGP_LOCK|FGP_CREAT,
>> -					GFP_NOFS);
>> -	if (!fio.encrypted_page)
>> -		goto put_out;
>> +	allocate_data_block(fio.sbi, NULL, fio.old_blkaddr, &newaddr,
>> +							&sum, CURSEG_COLD_DATA);
>> +
>> +	fio.encrypted_page = pagecache_get_page(META_MAPPING(fio.sbi), newaddr,
>> +					FGP_LOCK | FGP_CREAT, GFP_NOFS);
>> +	if (!fio.encrypted_page) {
>> +		err = -ENOMEM;
>> +		goto recover_block;
>> +	}
>>  
>>  	err = f2fs_submit_page_bio(&fio);
>>  	if (err)
>> @@ -593,6 +597,7 @@ static void move_encrypted_block(struct inode *inode, block_t bidx)
>>  	/* write page */
>>  	lock_page(fio.encrypted_page);
>>  
>> +	err = -EIO;
> 
> I found out that this will trigger error all the time, even in the successful
> case.
> I'll move assigning this to the below error cases only.

My bad, thanks for fixing it. :)

Thanks,

> 
> Thanks,
> 
> 
>>  	if (unlikely(!PageUptodate(fio.encrypted_page)))
>>  		goto put_page_out;
>>  	if (unlikely(fio.encrypted_page->mapping != META_MAPPING(fio.sbi)))
>> @@ -607,9 +612,9 @@ static void move_encrypted_block(struct inode *inode, block_t bidx)
>>  
>>  	/* allocate block address */
>>  	f2fs_wait_on_page_writeback(dn.node_page, NODE, true);
>> -	allocate_data_block(fio.sbi, NULL, fio.old_blkaddr, &fio.new_blkaddr,
>> -							&sum, CURSEG_COLD_DATA);
>> +
>>  	fio.rw = WRITE_SYNC;
>> +	fio.new_blkaddr = newaddr;
>>  	f2fs_submit_page_mbio(&fio);
>>  
>>  	dn.data_blkaddr = fio.new_blkaddr;
>> @@ -620,6 +625,10 @@ static void move_encrypted_block(struct inode *inode, block_t bidx)
>>  		set_inode_flag(F2FS_I(inode), FI_FIRST_BLOCK_WRITTEN);
>>  put_page_out:
>>  	f2fs_put_page(fio.encrypted_page, 1);
>> +recover_block:
>> +	if (err)
>> +		__f2fs_replace_block(fio.sbi, &sum, newaddr, fio.old_blkaddr,
>> +								true, true);
>>  put_out:
>>  	f2fs_put_dnode(&dn);
>>  out:
>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>> index d8e13b0..639c4ff 100644
>> --- a/fs/f2fs/segment.c
>> +++ b/fs/f2fs/segment.c
>> @@ -1439,8 +1439,7 @@ void rewrite_data_page(struct f2fs_io_info *fio)
>>  	f2fs_submit_page_mbio(fio);
>>  }
>>  
>> -static void __f2fs_replace_block(struct f2fs_sb_info *sbi,
>> -				struct f2fs_summary *sum,
>> +void __f2fs_replace_block(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
>>  				block_t old_blkaddr, block_t new_blkaddr,
>>  				bool recover_curseg, bool recover_newaddr)
>>  {
>> -- 
>> 2.7.0
>>
> 
> ------------------------------------------------------------------------------
> Site24x7 APM Insight: Get Deep Visibility into Application Performance
> APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
> Monitor end-to-end web transactions and take corrective actions now
> Troubleshoot faster and improve end-user experience. Signup Now!
> http://pubads.g.doubleclick.net/gampad/clk?id=272487151&iu=/4140
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> 
