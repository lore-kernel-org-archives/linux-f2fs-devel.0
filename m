From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH 2/3] f2fs: support checkpoint error injection
Date: Sat, 24 Sep 2016 11:32:08 +0800
Message-ID: <53ec17da-e6b3-cab4-d107-20ead1381ebd@huawei.com>
References: <20160923052458.83849-1-yuchao0@huawei.com>
	<20160923052458.83849-2-yuchao0@huawei.com>
	<20160923235345.GA23989@jaegeuk>
	<3cf62ebc-3bfa-b64c-5e63-cb3170560ac0@huawei.com>
	<20160924005216.GA24515@jaegeuk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1bndhW-00056U-El
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 24 Sep 2016 03:32:30 +0000
Received: from szxga01-in.huawei.com ([58.251.152.64])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1bndhS-00021I-K9
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 24 Sep 2016 03:32:30 +0000
In-Reply-To: <20160924005216.GA24515@jaegeuk>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: chao@kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 2016/9/24 8:52, Jaegeuk Kim wrote:
> On Sat, Sep 24, 2016 at 08:46:54AM +0800, Chao Yu wrote:
>> Hi Jaegeuk,
>>
>> On 2016/9/24 7:53, Jaegeuk Kim wrote:
>>> Hi Chao,
>>>
>>> The basic rule is to stop every operations once CP_ERROR_FLAG is set.
>>> But, this patch simply breaks the rule.
>>> For example, f2fs_write_data_page() currently exits with mapping_set_error().
>>> So this patch incurs missing dentry blocks in a valid checkpoint.
>>
>> Yes, that's right.
>>
>> How about triggering checkpoint error in f2fs_stop_checkpoint?
> 
> Let's just use src/godown in xfstests, since we don't need to trigger this
> multiple times in runtime.

After we inject checkpoint error into f2fs at first time, all write IOs will be
refused to be writebacked to storage, meanwhile read IOs can continuously go
through f2fs, so with checkpoint error injection being supported, we can support
to trigger random analogously power off by f2fs itself, instead of using tools.
It means it doesn't needs specified test cases where we must use godown ioctl,
but with normal testcases in xfstest/fsstress/lkp, in CP error injection enabled
f2fs, we can test power off cases.

Thanks,


------------------------------------------------------------------------------
