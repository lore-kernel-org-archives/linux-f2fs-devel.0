From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: set deadline to drop expired inmem
 pages
Date: Fri, 13 Apr 2018 09:25:37 +0800
Message-ID: <bb7d3b60-0629-ea80-c4ae-976a76abb034@huawei.com>
References: <20180408081312.6190-1-yuchao0@huawei.com>
 <09fd3144-d1c5-ca02-178d-b467d6fbe0e1@huawei.com>
 <20180413010433.GB51348@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1f6nTM-0001JZ-9m
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 13 Apr 2018 01:25:52 +0000
Received: from [45.249.212.32] (helo=huawei.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1f6nTK-00CVJ7-58
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 13 Apr 2018 01:25:52 +0000
In-Reply-To: <20180413010433.GB51348@jaegeuk-macbookpro.roam.corp.google.com>
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

On 2018/4/13 9:04, Jaegeuk Kim wrote:
> On 04/10, Chao Yu wrote:
>> Hi Jaegeuk,
>>
>> On 2018/4/8 16:13, Chao Yu wrote:
>>> f2fs doesn't allow abuse on atomic write class interface, so except
>>> limiting in-mem pages' total memory usage capacity, we need to limit
>>> start-commit time as well, otherwise we may run into infinite loop
>>> during foreground GC because target blocks in victim segment are
>>> belong to atomic opened file for long time.
>>>
>>> Now, we will check the condition with f2fs_balance_fs_bg in
>>> background threads, once if user doesn't commit data exceeding 30
>>> seconds, we will drop all cached data, so I expect it can keep our
>>> system running safely to prevent Dos attack.
>>
>> Is it worth to add this patch to avoid abuse on atomic write interface by user?
> 
> Hmm, hope to see a real problem first in this case.

I think this can be a more critical security leak instead of a potential issue
which we can wait for someone reporting that can be too late.

For example, user can simply write a huge file whose data spread in all f2fs
segments, once user open that file as atomic, foreground GC will suffer
deadloop, causing denying any further service of f2fs.

Thanks,

> 
>> Thanks,
> 
> .
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
