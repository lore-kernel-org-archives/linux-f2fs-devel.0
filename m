From: Rosen Penev <rosenp@gmail.com>
Subject: Big Endian mount/fsck failing
Date: Tue, 5 Feb 2019 15:14:13 -0800
Message-ID: <CAKxU2N_jQmEN5PiSEhvJ5iUyvpCN7aZH4gF75TLLzV=2iiw2xw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <rosenp@gmail.com>) id 1gr9vE-0002cM-Lm
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 05 Feb 2019 23:14:32 +0000
Received: from mail-ot1-f50.google.com ([209.85.210.50])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1gr9vD-00663q-7c
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 05 Feb 2019 23:14:32 +0000
Received: by mail-ot1-f50.google.com with SMTP id n8so8863372otl.6
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 05 Feb 2019 15:14:30 -0800 (PST)
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net

It errors on

[ASSERT] (build_curseg:1529) array

looking at the surrounding code, it's a malloc of size 144 that fails.
No idea why.

Running f2fs-tools on a MIPS 74Kc router (TP-LINK Archer C7v2).

Mounting the device with mount results in a kernel panic or something
that causes out of memory issues. I don't have a serial console hooked
up to see.

This is with version 1.12.
