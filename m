From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: fix to account IO correctly
Date: Mon, 22 Oct 2018 09:15:25 +0800
Message-ID: <a0b8373d-8b5f-6502-a230-5a67a815caa3@huawei.com>
References: <20181017094954.67547-1-yuchao0@huawei.com>
 <20181018190612.GD50556@jaegeuk-macbookpro.roam.corp.google.com>
 <9e586616-5cfa-5515-008c-e7bba1e3c4a1@huawei.com>
 <20181019231212.GB11541@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181019231212.GB11541@jaegeuk-macbookpro.roam.corp.google.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chao@kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2018/10/20 7:12, Jaegeuk Kim wrote:
> On 10/19, Chao Yu wrote:
>> On 2018/10/19 3:06, Jaegeuk Kim wrote:
>>>
>>> On 10/17, Chao Yu wrote:
>>>> Below race can cause reversed reference on F2FS_RD_DATA, there is
>>>> the same issue in f2fs_submit_page_bio(), fix them by relocate
>>>> __submit_bio() and inc_page_count.
>>>>
>>>> Thread A			Thread B
>>>> - f2fs_write_begin
>>>>  - f2fs_submit_page_read
>>>>  - __submit_bio
>>>> 				- f2fs_read_end_io
>>>> 				 - __read_end_io
>>>> 				 - dec_page_count(, F2FS_RD_DATA)
>>>>  - inc_page_count(, F2FS_RD_DATA)
>>>
>>> Let me integrate the change into the original patch and test a bit.
>>
>> IMO, it will be better to split this change into two, we can fix the
>> location of inc_page_count(, F2FS_RD_DATA) directly in your patch,
>> meanwhile we can add one more patch to fix the same issue in
>> f2fs_submit_page_bio(), in where the problem exists for long time, it needs
>> to send fixing patch to stable kernel mailing list.
> 
> How about this?
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git/commit/?h=dev&id=3cca724d115fc1590c46585e264a391da06c345a
> https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git/commit/?h=dev&id=8e3eed6f80c9c4cfe875f995b38dde590e444dc6

That's correct, I just modified the commit message a bit to adapt the
change and add 'Fixes' line in v2, could you merge that one?

Thanks,

> 
>>
>> Thanks,
>>
>>>
>>> Thanks,
>>>
>>>>
>>>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>>>> ---
>>>>  fs/f2fs/data.c | 6 +++---
>>>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
>>>> index c03bd0c2ed22..8b9240762156 100644
>>>> --- a/fs/f2fs/data.c
>>>> +++ b/fs/f2fs/data.c
>>>> @@ -480,10 +480,10 @@ int f2fs_submit_page_bio(struct f2fs_io_info *fio)
>>>>  	}
>>>>  	bio_set_op_attrs(bio, fio->op, fio->op_flags);
>>>>  
>>>> -	__submit_bio(fio->sbi, bio, fio->type);
>>>> -
>>>>  	inc_page_count(fio->sbi, is_read_io(fio->op) ?
>>>>  			__read_io_type(page): WB_DATA_TYPE(fio->page));
>>>> +
>>>> +	__submit_bio(fio->sbi, bio, fio->type);
>>>>  	return 0;
>>>>  }
>>>>  
>>>> @@ -612,8 +612,8 @@ static int f2fs_submit_page_read(struct inode *inode, struct page *page,
>>>>  		return -EFAULT;
>>>>  	}
>>>>  	ClearPageError(page);
>>>> -	__submit_bio(F2FS_I_SB(inode), bio, DATA);
>>>>  	inc_page_count(F2FS_I_SB(inode), F2FS_RD_DATA);
>>>> +	__submit_bio(F2FS_I_SB(inode), bio, DATA);
>>>>  	return 0;
>>>>  }
>>>>  
>>>> -- 
>>>> 2.18.0.rc1
>>>
>>> .
>>>
> 
> .
> 
