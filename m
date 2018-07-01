From: "Xu, Wen" <wen.xu@gatech.edu>
Subject: Re: Unfixed bug in f2fs-dev branch
Date: Sun, 1 Jul 2018 02:30:23 +0000
Message-ID: <B9D85AA9-AD52-4B6B-A34C-D154BB575215@gatech.edu>
References: <4C84D904-982F-42E1-910F-202DB0BAABC3@gatech.edu>
 <0c0693e7-8ccb-090f-3f70-95f42dc2f0ad@huawei.com>
 <CBE669A7-5C20-4CFC-AB23-F2AEE877A2C6@gatech.edu>
 <ed513d15-cc84-5ea4-0f6a-947187073980@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <wen.xu@gatech.edu>) id 1fZS8H-0002ay-9E
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 01 Jul 2018 02:30:33 +0000
Received: from mail-eopbgr700107.outbound.protection.outlook.com
 ([40.107.70.107] helo=NAM04-SN1-obe.outbound.protection.outlook.com)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-SHA384:256) (Exim 4.90_1)
 id 1fZS8F-00Dnf9-6U
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 01 Jul 2018 02:30:33 +0000
In-Reply-To: <ed513d15-cc84-5ea4-0f6a-947187073980@kernel.org>
Content-Language: en-US
Content-ID: <784B072A830B9842867FD4534C426AE0@namprd07.prod.outlook.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <chao@kernel.org>
Cc: "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>

Yeah, thanks.

-Wen

> On Jun 30, 2018, at 10:29 PM, Chao Yu <chao@kernel.org> wrote:
> 
> On 2018/7/1 5:08, Xu, Wen wrote:
>> Thanks for your efforts. It is fixed regarding my testing.
> 
> Thanks very much for the test. :)
> 
> If you don't mind, I will reply to bug report posts, and tag them as fixed status.
> 
> Thanks,
> 
>> 
>> -Wen
>> 
>>> On Jun 30, 2018, at 6:17 AM, Chao Yu <yuchao0@huawei.com> wrote:
>>> 
>>> Hi Wen Xu,
>>> 
>>> On 2018/6/30 1:31, Xu, Wen wrote:
>>>> Hi Chao,
>>>> 
>>>> Thank you for your quick response for my bugs!
>>>> 
>>>> After testing your patches, I found all my bugs are fixed except for https://bugzilla.kernel.org/show_bug.cgi?id=200179
>>>> The kernel still panics with KASAN report that I have already pasted in the link. Please check it.
>>> 
>>> I just sent another patch for that, later I will add it into my tree, could you
>>> please test that patch? I hope it can fix the issue current stack showed.
>>> 
>>> Thanks,
>>> 
>>>> 
>>>> -Wen
>>>> 
>>> 
>> 
>> 
>> ------------------------------------------------------------------------------
>> Check out the vibrant tech community on one of the world's most
>> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
>> _______________________________________________
>> Linux-f2fs-devel mailing list
>> Linux-f2fs-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
