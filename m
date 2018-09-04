From: Patrick Doyle <wpdster@gmail.com>
Subject: Are there limitation to the number of named pipes/FIFO's
 supported by F2FS?
Date: Tue, 4 Sep 2018 12:28:41 -0400
Message-ID: <CAF_dkJChk25fWa+bTndWa-qRsy6mW3Mj3uemXpk0QxLgY=fzeg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <wpdster@gmail.com>) id 1fxECZ-0000r2-KD
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 04 Sep 2018 16:29:15 +0000
Received: from mail-oi0-f41.google.com ([209.85.218.41])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1fxECY-008O5A-7b
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 04 Sep 2018 16:29:15 +0000
Received: by mail-oi0-f41.google.com with SMTP id p84-v6so7912501oic.4
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 04 Sep 2018 09:29:13 -0700 (PDT)
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

I have created an f2fs partition on which to build embedded Linux
images (using Yocto/OpenEmbedded/Bitbake).

I just had a build fail where all 20 parallel makes failed with errors
of the form:

OSError: [Errno 5] Input/output error:
'/home/wpd/src/20180904-test/apps_proc/poky/build/tmp-glibc/work/armv7a-vfp-neon-oe-linux-gnueabi/libxml2/2.9.2-r0/temp/fifo.32426'

This build completed successfully in the past, including just this
morning (on this filesystem).

I believe by design (and benchmarks I have researched) that F2FS is
the best approach for SSD based file systems, but this will mark the
second time in less than a week of having put F2FS in operation that I
will have to back up my partition, reformat it with different flags,
and restore it from my backup.   I am now frustrated.

What options would you recommend for a 1TB SSD formatted with F2FS to
be used in an environment that generates Linux system images?  This
environment creates many object files, named pipes, logfiles, etc...

I will start my new backup now, and hope to learn your recommendation
before I am ready to issue my next mkfs command.

--wpd

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
