From: Chao Yu <yuchao0@huawei.com>
Subject: Re: Big Endian mount/fsck failing
Date: Fri, 15 Feb 2019 16:36:02 +0800
Message-ID: <a2211f89-2ba8-4e7c-e12c-af47ffe13d92@huawei.com>
References: <CAKxU2N_jQmEN5PiSEhvJ5iUyvpCN7aZH4gF75TLLzV=2iiw2xw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1guYyg-0006PQ-Hp
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 15 Feb 2019 08:36:10 +0000
Received: from szxga07-in.huawei.com ([45.249.212.35] helo=huawei.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1guYyd-008bhw-RT
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 15 Feb 2019 08:36:10 +0000
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 3525DAD6F0C5DEA8C3AA
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 15 Feb 2019 16:35:59 +0800 (CST)
In-Reply-To: <CAKxU2N_jQmEN5PiSEhvJ5iUyvpCN7aZH4gF75TLLzV=2iiw2xw@mail.gmail.com>
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
To: Rosen Penev <rosenp@gmail.com>, linux-f2fs-devel@lists.sourceforge.net

On 2019/2/6 7:14, Rosen Penev wrote:
> It errors on
> 
> [ASSERT] (build_curseg:1529) array
> 
> looking at the surrounding code, it's a malloc of size 144 that fails.
> No idea why.

Could gdb work on your platform, maybe we can debug into it, and to check
the real size we allocate, if it is as we expect, I doubt that we run out
of memory? at that time, we can check memory usage of fsck and others...

> 
> Running f2fs-tools on a MIPS 74Kc router (TP-LINK Archer C7v2).
> 
> Mounting the device with mount results in a kernel panic or something

Do you have call stack?

Thanks,

> that causes out of memory issues. I don't have a serial console hooked
> up to see.
> 
> This is with version 1.12.
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> 
> 
