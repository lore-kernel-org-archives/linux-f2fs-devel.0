From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: clear cold data flag if IO is not
 counted
Date: Tue, 16 Oct 2018 09:31:25 +0800
Message-ID: <405b1521-cbfb-9f09-0d16-ae837b756cbb@huawei.com>
References: <20181010212217.52289-1-jaegeuk@kernel.org>
 <3f08031e-d195-5bc1-67e1-f3b6eab3506b@huawei.com>
 <20181015230807.GC1296@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1gCECx-0005JG-Qa
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 16 Oct 2018 01:31:39 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gCECv-002LVd-PU
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 16 Oct 2018 01:31:39 +0000
In-Reply-To: <20181015230807.GC1296@jaegeuk-macbookpro.roam.corp.google.com>
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
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 2018/10/16 7:08, Jaegeuk Kim wrote:
> On 10/15, Chao Yu wrote:
>> On 2018/10/11 5:22, Jaegeuk Kim wrote:
>>> If we clear the cold data flag out of the writeback flow, we can miscount
>>> -1 by end_io.
>>
>> I didn't get it, which count do you mean?
> 
> It's the number of dirty pages.
> 
> Balancing F2FS Async:
>   - IO (CP:    1, Data:   -1, Flush: (   0    0    1), Discard: (   0 129304)) cmd:    0 undiscard:   0
> 

So I guess the race should be:

GC thread:				IRQ
- move_data_page()
 - set_page_dirty()
  - clear_cold_data()
					- f2fs_write_end_io()
					 - type = WB_DATA_TYPE(page);
					   here, we get wrong type
					 - dec_page_count(sbi, type);
 - f2fs_wait_on_page_writeback()

How about relocate wait_writeback & set_page_dirty to avoid above race:

move_data_page()

retry:
		f2fs_wait_on_page_writeback(page, DATA, true);
		set_page_dirty(page);

Thanks,

>>
>> Thanks,
>>
>>>
>>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>>> ---
>>>  fs/f2fs/data.c | 4 ----
>>>  1 file changed, 4 deletions(-)
>>>
>>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
>>> index 29a9d3b8f709..4102799b5558 100644
>>> --- a/fs/f2fs/data.c
>>> +++ b/fs/f2fs/data.c
>>> @@ -2636,10 +2636,6 @@ static int f2fs_set_data_page_dirty(struct page *page)
>>>  	if (!PageUptodate(page))
>>>  		SetPageUptodate(page);
>>>  
>>> -	/* don't remain PG_checked flag which was set during GC */
>>> -	if (is_cold_data(page))
>>> -		clear_cold_data(page);
>>> -
>>>  	if (f2fs_is_atomic_file(inode) && !f2fs_is_commit_atomic_write(inode)) {
>>>  		if (!IS_ATOMIC_WRITTEN_PAGE(page)) {
>>>  			f2fs_register_inmem_page(inode, page);
>>>
> 
> .
> 
