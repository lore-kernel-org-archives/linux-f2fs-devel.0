From: Patrick Doyle <wpdster@gmail.com>
Subject: Out of inodes on my f2fs partition
Date: Thu, 30 Aug 2018 10:44:39 -0400
Message-ID: <CAF_dkJAhK_1WtPF_2s5xUX60k87iMLbAYHV1=0S2aKQv3jh8Ng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <wpdster@gmail.com>) id 1fvOCE-0000gy-6l
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 30 Aug 2018 14:45:18 +0000
Received: from mail-oi0-f42.google.com ([209.85.218.42])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1fvOC8-003pCm-KL
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 30 Aug 2018 14:45:18 +0000
Received: by mail-oi0-f42.google.com with SMTP id k81-v6so9734887oib.9
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 30 Aug 2018 07:45:12 -0700 (PDT)
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

I have run out of space on my 1TB SSD formatted with f2fs, but df
shows it is only 35% full.

df -i shows 100% of the inodes are in use.

What can I do?  I don't see any mkfs.f2fs or mount options for
increasing the number of inodes.

--wpd

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
