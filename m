From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH v2] generic: test i_mode recovery after power
 failure
Date: Wed, 6 Mar 2019 10:29:10 +0800
Message-ID: <0f1af38b-5dbf-a56a-c0c1-72cf9fafb515@huawei.com>
References: <20190305114744.129633-1-yuchao0@huawei.com>
 <20190305205344.GC26298@dastard>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1h1MJ7-0006Nt-6U
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 06 Mar 2019 02:29:21 +0000
Received: from szxga06-in.huawei.com ([45.249.212.32] helo=huawei.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1h1MJ4-006CSq-D1
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 06 Mar 2019 02:29:21 +0000
In-Reply-To: <20190305205344.GC26298@dastard>
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
To: Dave Chinner <david@fromorbit.com>
Cc: guaneryu@gmail.com, fdmanana@gmail.com, fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 2019/3/6 4:53, Dave Chinner wrote:
> On Tue, Mar 05, 2019 at 07:47:44PM +0800, Chao Yu wrote:
>> After fsync, filesystem should guarantee inode metadata including
>> permission info being persisted, so even after sudden power-cut,
>> during mount, we should recover i_mode fields correctly, in order
>> to not loss those meta info.
>>
>> So adding this testcase to check whether generic filesystem can
>> guarantee that.
> 
> Can I make a suggestion here?
> 
> I've noticed that we are getting a lot of these one-off, random
> "fsync persists one specific piece of metadata in one specific case"
> tests, mainly in response to some fsync bug that was found in btrfs.
> This is reactive, and does not find new bugs in this area.
> 
> We are also beyond the point where the number of tests is
> maintainable (e.g. to be able to make infrastructure changes), so we
> really should be looking to consolidate largely similar tests into
> single tests where possible.
> 
> I'd strongly suggest that a robust fsync tester should be written
> for all the cases that are currently being addressed in an ad hoc
> fashion. Then they can be consolidated into a single test run, and
> we can get rid of all the one-off "fsync failed on this <specific
> thing>" tests from the harness.

Thanks for the suggestion, and that makes sense.

> 
> Oh, wait, we *already have that infrastructure*: src/fsync-tester.c
> and generic/311.
> 
> Can we please consider rolling all of these "do something, fsync,
> drop-writes, remount check" into fsync-tester.c and do the same for
> all future one-off "did fsync persist X" tests?

Let me add this testcase into fsync-tester.c, still we need add new
testcase in generic/ directory instead of changing generic/311 directly,
right? since as I remember that Eryu mentioned that:

"Usually we don't add new sub-tests to existing tests, so new failures
introduced by the new sub-tests won't be treated as false regressions.
Please add a new test instead."

https://patchwork.kernel.org/patch/10042149/

Or to avoid redundant copied code from generic/311 in each fsync related
patch, do I need just add my case into fsync_tester.c? and before
announcement of fstests master branch, we can add one testcase into
generic/ directory, in that testcase we gather/test all new added cases in
fsync_tester.c recently.

Which one is easier for you to maintain?

Thanks,

> 
> Cheers,
> 
> Dave.
> 
