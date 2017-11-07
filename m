From: Yunlong Song <yunlong.song@huawei.com>
Subject: Re: [PATCH v2] f2fs: add bug_on when f2fs_gc even fails
 to get one victim
Date: Tue, 7 Nov 2017 11:16:03 +0800
Message-ID: <cafd59c4-1a39-f54b-095e-24430a79437e@huawei.com>
References: <1507729864-118702-1-git-send-email-yunlong.song@huawei.com>
 <1507901500-162168-1-git-send-email-yunlong.song@huawei.com>
 <20171103034402.GC11335@jaegeuk-macbookpro.roam.corp.google.com>
 <3b26badb-c34e-3c2d-74a2-26ecef1f64ff@huawei.com>
 <20171107023835.GG88544@jaegeuk-macbookpro.roam.corp.google.com>
 <20171107024058.GH88544@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.194]
 helo=mx.sourceforge.net)
 by sfs-ml-2.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <yunlong.song@huawei.com>) id 1eBuNv-0004lc-Ec
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 07 Nov 2017 03:17:07 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190])
 by sfi-mx-4.v28.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
 (Exim 4.89) id 1eBuNu-0000ME-5v
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 07 Nov 2017 03:17:07 +0000
In-Reply-To: <20171107024058.GH88544@jaegeuk-macbookpro.roam.corp.google.com>
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
Cc: yunlong.song@icloud.com, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, miaoxie@huawei.com

Because I find that some out-of-free problem is caused by the failure
of get victim target. For example, chao has pointed out that he has
found out a bug when adding this bug_on last week.

On 2017/11/7 10:40, Jaegeuk Kim wrote:
> On 11/06, Jaegeuk Kim wrote:
>> On 11/06, Yunlong Song wrote:
>>> Agree.
>>>
>>> On 2017/11/3 11:44, Jaegeuk Kim wrote:
>>>> On 10/13, Yunlong Song wrote:
>>>>> This can help us to debug on some corner case.
>>>>>
>>>>> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
>>>>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>>>>> ---
>>>>>    fs/f2fs/gc.c | 6 +++++-
>>>>>    1 file changed, 5 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
>>>>> index 197ebf4..2b03202 100644
>>>>> --- a/fs/f2fs/gc.c
>>>>> +++ b/fs/f2fs/gc.c
>>>>> @@ -986,6 +986,7 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
>>>>>    		.ilist = LIST_HEAD_INIT(gc_list.ilist),
>>>>>    		.iroot = RADIX_TREE_INIT(GFP_NOFS),
>>>>>    	};
>>>>> +	bool need_fggc = false;
>>>>>    	trace_f2fs_gc_begin(sbi->sb, sync, background,
>>>>>    				get_pages(sbi, F2FS_DIRTY_NODES),
>>>>> @@ -1018,8 +1019,10 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
>>>>>    			if (ret)
>>>>>    				goto stop;
>>>>>    		}
>>>>> -		if (has_not_enough_free_secs(sbi, 0, 0))
>>>>> +		if (has_not_enough_free_secs(sbi, 0, 0)) {
>>>>>    			gc_type = FG_GC;
>>>>> +			need_fggc = true;
>>>>> +		}
>>>>>    	}
>>>>>    	/* f2fs_balance_fs doesn't need to do BG_GC in critical path. */
>>>>> @@ -1028,6 +1031,7 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
>>>>>    		goto stop;
>>>>>    	}
>>>>>    	if (!__get_victim(sbi, &segno, gc_type)) {
>>>>> +		f2fs_bug_on(sbi, !total_freed && need_fggc);
>>>> Just like this?
>>> That's OK.
>> I'm not quite sure whether this is really a bug_on case.
>> Let me make it WARN_ON() for debugging purpose first.
> BTW, why is this the special case where BG_GC detects FG_GC?
>
>> Thanks,
>>
>>>> 		f2fs_bug_on(sbi, !total_freed && !sync && gc_type == FG_GC);
>>>>
>>>>>    		ret = -ENODATA;
>>>>>    		goto stop;
>>>>>    	}
>>>>> -- 
>>>>> 1.8.5.2
>>>> .
>>>>
>>> -- 
>>> Thanks,
>>> Yunlong Song
>>>
> .
>

-- 
Thanks,
Yunlong Song



------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
