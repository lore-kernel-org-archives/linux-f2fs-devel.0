From: Chao Yu <yuchao0@huawei.com>
Subject: Re: Unfixed bug in f2fs-dev branch
Date: Sat, 30 Jun 2018 18:17:45 +0800
Message-ID: <0c0693e7-8ccb-090f-3f70-95f42dc2f0ad@huawei.com>
References: <4C84D904-982F-42E1-910F-202DB0BAABC3@gatech.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1fZCxh-00022m-IE
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 30 Jun 2018 10:18:37 +0000
Received: from [45.249.212.35] (helo=huawei.com)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fZCxf-00DI4a-Hv
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 30 Jun 2018 10:18:37 +0000
In-Reply-To: <4C84D904-982F-42E1-910F-202DB0BAABC3@gatech.edu>
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
To: "Xu, Wen" <wen.xu@gatech.edu>
Cc: "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>

Hi Wen Xu,

On 2018/6/30 1:31, Xu, Wen wrote:
> Hi Chao,
> 
> Thank you for your quick response for my bugs!
> 
> After testing your patches, I found all my bugs are fixed except for https://bugzilla.kernel.org/show_bug.cgi?id=200179
> The kernel still panics with KASAN report that I have already pasted in the link. Please check it.

I just sent another patch for that, later I will add it into my tree, could you
please test that patch? I hope it can fix the issue current stack showed.

Thanks,

> 
> -Wen
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
