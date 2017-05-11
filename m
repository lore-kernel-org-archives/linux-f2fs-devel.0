From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH 1/3] f2fs: use f2fs_submit_page_bio for
 ra_meta_pages
Date: Thu, 11 May 2017 09:47:12 +0800
Message-ID: <95d5a9b2-0e0d-e513-5b45-33a35fd2d3d1@huawei.com>
References: <20170510234816.3373-1-jaegeuk@kernel.org>
	<afcbcade-806c-23a4-f766-9d41c896a37c@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1d8dCZ-0000bW-77
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 11 May 2017 01:47:35 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1d8dCX-0000r5-Ht
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 11 May 2017 01:47:35 +0000
In-Reply-To: <afcbcade-806c-23a4-f766-9d41c896a37c@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 2017/5/11 9:24, Chao Yu wrote:
> Hi Jaegeuk,
> 
> On 2017/5/11 7:48, Jaegeuk Kim wrote:
>> This patch avoids to use f2fs_submit_merged_bio for read, which was the only
>> read case.
> 
> This makes f2fs losing the chance to merge multiple pages into one bio during
> reading continuous physical blocks, it may cause potential performance
> regression, how about using a local bio in ra_meta_pages to cache more pages?

BTW, need to remove sbi->read_io as well?

Thanks,

> 
> Thanks,
> 
>>
>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>> ---
>>  fs/f2fs/checkpoint.c | 4 +---
>>  1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
>> index ea9c317b5916..8d92f8249000 100644
>> --- a/fs/f2fs/checkpoint.c
>> +++ b/fs/f2fs/checkpoint.c
>> @@ -207,12 +207,10 @@ int ra_meta_pages(struct f2fs_sb_info *sbi, block_t start, int nrpages,
>>  		}
>>  
>>  		fio.page = page;
>> -		fio.old_blkaddr = fio.new_blkaddr;
>> -		f2fs_submit_page_mbio(&fio);
>> +		f2fs_submit_page_bio(&fio);
>>  		f2fs_put_page(page, 0);
>>  	}
>>  out:
>> -	f2fs_submit_merged_bio(sbi, META, READ);
>>  	blk_finish_plug(&plug);
>>  	return blkno - start;
>>  }
>>
> 
> 
> .
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
