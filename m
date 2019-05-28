From: Ju Hyung Park <qkrwngud825@gmail.com>
Subject: Re: [PATCH 2/2] mkfs.f2fs: make the default extensions
 list much more sensical
Date: Tue, 28 May 2019 19:28:40 +0900
Message-ID: <CAD14+f0F0aeqaJMFqoQTBY7wjqAF2H98+Ruvsd3Xd_Wuua8mkw@mail.gmail.com>
References: <20190416064355.29712-1-qkrwngud825@gmail.com>
 <20190416064355.29712-2-qkrwngud825@gmail.com>
 <afdf2ade-6cb7-a335-3584-22bd2681e502@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <qkrwngud825@gmail.com>) id 1hVZLo-0007v0-9o
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 28 May 2019 10:29:00 +0000
Received: from mail-qk1-f196.google.com ([209.85.222.196])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1hVZLn-000hTq-2T
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 28 May 2019 10:29:00 +0000
Received: by mail-qk1-f196.google.com with SMTP id t64so21514955qkh.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 28 May 2019 03:28:58 -0700 (PDT)
In-Reply-To: <afdf2ade-6cb7-a335-3584-22bd2681e502@huawei.com>
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

Hi Chao,

On Tue, May 28, 2019 at 7:19 PM Chao Yu <yuchao0@huawei.com> wrote:
> How about adding below extensions:
>
>         "zip",
>         "bin",
>         "dat",
>         "txt",

zip is capable of random updates. I didn't add bz2 for the same reason.
But I do agree that most users won't be constantly updating zip files.

I personally use my Android device with zip treated as cold, but I'm
not sure if it makes good sense to make it as the default that's
supposed to run under various scenarios.

How much different is the random write performance from cold to hot?

But I'm against the idea of adding the rest 3 extensions.
"bin" and "dat" is way too generic. You wouldn't know if a program
happens to heavily update files named .bin/.dat.

For txt, it won't be uncommon for a user to update it frequently.
Moreover, most txt size is pretty small anyways.

And finally, circling back to your original concern, we should be more
careful adding extensions as there's a limit.

Thanks.
