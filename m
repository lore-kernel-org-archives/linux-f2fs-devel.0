From: Rosen Penev <rosenp@gmail.com>
Subject: Re: Big Endian mount/fsck failing
Date: Fri, 15 Feb 2019 00:39:22 -0800
Message-ID: <CAKxU2N9gQGRnUqom=qE9cdtCerhdgMi+kMqMSfr1JW=-dWEFmQ@mail.gmail.com>
References: <CAKxU2N_jQmEN5PiSEhvJ5iUyvpCN7aZH4gF75TLLzV=2iiw2xw@mail.gmail.com>
 <a2211f89-2ba8-4e7c-e12c-af47ffe13d92@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <rosenp@gmail.com>) id 1guZ25-0006YS-71
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 15 Feb 2019 08:39:41 +0000
Received: from mail-ot1-f68.google.com ([209.85.210.68])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1guZ23-008rpK-Fy
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 15 Feb 2019 08:39:41 +0000
Received: by mail-ot1-f68.google.com with SMTP id v62so6445424otb.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 15 Feb 2019 00:39:39 -0800 (PST)
In-Reply-To: <a2211f89-2ba8-4e7c-e12c-af47ffe13d92@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <yuchao0@huawei.com>
Cc: linux-f2fs-devel@lists.sourceforge.net

On Fri, Feb 15, 2019 at 12:36 AM Chao Yu <yuchao0@huawei.com> wrote:
>
> On 2019/2/6 7:14, Rosen Penev wrote:
> > It errors on
> >
> > [ASSERT] (build_curseg:1529) array
> >
> > looking at the surrounding code, it's a malloc of size 144 that fails.
> > No idea why.
>
> Could gdb work on your platform, maybe we can debug into it, and to check
> the real size we allocate, if it is as we expect, I doubt that we run out
> of memory? at that time, we can check memory usage of fsck and others...
it should. Not too sure how to use.
>
> >
> > Running f2fs-tools on a MIPS 74Kc router (TP-LINK Archer C7v2).
> >
> > Mounting the device with mount results in a kernel panic or something
>
> Do you have call stack?
No. syslog is also useless as too many messages are written (4KB limit).
>
> Thanks,
>
> > that causes out of memory issues. I don't have a serial console hooked
> > up to see.
> >
> > This is with version 1.12.
> >
> >
> > _______________________________________________
> > Linux-f2fs-devel mailing list
> > Linux-f2fs-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> >
> >
>
