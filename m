From: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH 1/4] f2fs: fix to clear private data in page
Date: Fri, 29 Apr 2016 19:19:15 +0800
Message-ID: <19ffa977-a512-ff49-554a-e15332e41b64@kernel.org>
References: <572228AC.30109@kernel.org>
 <20160428232909.GA41124@jaegeuk.gateway>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160428232909.GA41124@jaegeuk.gateway>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Jaegeuk,

On 2016/4/29 7:29, Jaegeuk Kim wrote:
> Hi Chao,
> 
> Could you check your email setting?
> All the patches are corrupted, as git am says.

My bad, I use thunderbird for sending patches, but yesterday I upgrade it to
version 45.0, it forces wrapping long line for email content, so the patches
become corrupted to git-am.

Later, I will resend them.

Thanks,

> 
> Thanks,
> 
> On Thu, Apr 28, 2016 at 11:13:48PM +0800, Chao Yu wrote:
>> From: Chao Yu <yuchao0@huawei.com>
>>
>> Private data in page should be removed during ->releasepage or
>> ->invalidatepage, otherwise garbage data would be remained in that page.
>>
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>> ---
>>  fs/f2fs/data.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
>> index 38ce5d6..888f178 100644
>> --- a/fs/f2fs/data.c
>> +++ b/fs/f2fs/data.c
>> @@ -1723,6 +1723,7 @@ void f2fs_invalidate_page(struct page *page, unsigned int
>> offset,
>>  	if (IS_ATOMIC_WRITTEN_PAGE(page))
>>  		return;
>>
>> +	set_page_private(page, 0);
>>  	ClearPagePrivate(page);
>>  }
>>
>> @@ -1736,6 +1737,7 @@ int f2fs_release_page(struct page *page, gfp_t wait)
>>  	if (IS_ATOMIC_WRITTEN_PAGE(page))
>>  		return 0;
>>
>> +	set_page_private(page, 0);
>>  	ClearPagePrivate(page);
>>  	return 1;
>>  }
>> -- 
>> 2.7.2
