From: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH v5] f2fs: introduce a method to make nat
 journal more fresh
Date: Sat, 14 Apr 2018 09:22:35 +0800
Message-ID: <dd356978-c426-4b7c-2494-f7fd02d2ccb2@kernel.org>
References: <1523344306-16493-1-git-send-email-heyunlei@huawei.com>
 <527e85f8-e407-1897-9929-b9a8be53f557@huawei.com>
 <20180414004800.GA35840@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chao@kernel.org>) id 1f79u0-0003BV-Pl
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 14 Apr 2018 01:22:52 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1f79ty-00GWYO-2u
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 14 Apr 2018 01:22:52 +0000
In-Reply-To: <20180414004800.GA35840@jaegeuk-macbookpro.roam.corp.google.com>
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
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
Cc: zhangdianfang@huawei.com, linux-f2fs-devel@lists.sourceforge.net

On 2018/4/14 8:48, Jaegeuk Kim wrote:
> I removed this patch in my test branch, since it simply gave a kernel panic.
> Please test before sending patches.

Sorry, I didn't find this bug in previous review.

Look at this patch again,

> +	/* journal hit case, try to locate set in journal */
> +	if (!remove_journal && head->entry_cnt <= NAT_JOURNAL_ENTRIES)

head pointer can be a random value before using.

To Yunlei, could you please fix this, and do the test (at least with xfstest)
before resending it.

Thanks,

> 
> repro
> 1. encrypt a dir
> 2. dd to create 10MB-sized file in the dir
> 
> On 04/12, Chao Yu wrote:
>> On 2018/4/10 15:11, Yunlei He wrote:
>>> This patch introduce a method to make nat journal more fresh:
>>> i.  sort set list using dirty entry number and cp version
>>>     average value.
>>> ii. if meet with cache hit, update average version valus with
>>>     current cp version.
>>>
>>> With this patch, newly modified nat set will flush to journal,
>>> and flush old nat set with same dirty entry number to nat area.
>>>
>>> Signed-off-by: Yunlei He <heyunlei@huawei.com>
>>
>> Reviewed-by: Chao Yu <yuchao0@huawei.com>
>>
>> Thanks,
> 
> ------------------------------------------------------------------------------
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> 

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
