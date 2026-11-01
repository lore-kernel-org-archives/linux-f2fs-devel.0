Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC35606A324
	for <linux-f2fs-devel@archiver.kernel.org>; Sun,  1 Nov 2026 09:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=gp1REZ7X;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=N4GPH2V0;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=dpvQLZvm;
	dkim=neutral header.d=izzo.pro header.i=@izzo.pro header.a=rsa-sha256 header.s=soverin header.b=kZ43Zk8y;
	dkim=neutral header.d=izzo.pro header.i=@izzo.pro header.a=rsa-sha256 header.s=soverin1 header.b=bmKaie9W
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:Message-Id:Date:Mime-Version:Sender:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=pdvdZXl8R6mcL1pOjcbsI1G9v/tmSsZhVkLEiYR7iwI=; b=gp1REZ7XY+Jm5Ohvj+vKgjIrQa
	Baxt0uNRpQ8f5XCxdqKOXaRnrh0METf+68FI8zGrk/65r+9TmjTQibzUjbAI9xIkQUNbdcfLtx34+
	oXcgiQbsSbW3cHLorUOjDpU4RLblB2XrHPlFvc90PT6s0f7ShMX5knMA0ET4QGOTvur4=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xNRji-000000006r6-0eVP;
	Sun, 01 Nov 2026 09:20:22 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <federico@izzo.pro>) id 1xNRjg-000000006qp-1MbV
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 01 Nov 2026 09:20:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=From:Subject:To:Message-Id:Date:Content-Type:
 Content-Transfer-Encoding:Mime-Version:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GbwqZZ7XWtPrAl/bhtA/8lzVvVD5LPA1qK2TszjVfmc=; b=N4GPH2V0oLeehHvqPePN3sHnSR
 NI/2j/nnM27GsIIZJXDrGX4WJbfdIbnLVczcfc5fkkXHzur5Kwcb+/Tctg0k8nn36feJJ5h0Pu1uG
 +y1Z6HttHLcuo/aFDAPMgrvPsKECfZiu6xNIJv8ubWzFTpirUh3wrk9quwfYjyGHhaA0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=From:Subject:To:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
 Mime-Version:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GbwqZZ7XWtPrAl/bhtA/8lzVvVD5LPA1qK2TszjVfmc=; b=dpvQLZvmtuD9zshtdtMk66lcOZ
 KXJLiJBaIBYl8IENWVghsI8Tf6sLCEjjxd2NsYU1QAElIcJaTS+64Splljfnw6C7R6ujK+LtkidFO
 6eMGkY81AdszAWsMUovigAkTHuBjbG3lEl0hBay5lpVciustokzR7ZAT8buCyURxBqXg=;
Received: from outbound.soverin.net ([185.233.34.146])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNRje-000000008N4-1swF
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 01 Nov 2026 09:20:20 +0000
Received: from smtp.soverin.net (unknown [10.103.10.154])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by outbound.soverin.net (Postfix) with ESMTPS id 4jHTM25F3tz1SSX
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun,  1 Nov 2026 09:00:30 +0000 (UTC)
Received: from smtp.soverin.net (smtp.soverin.net [10.103.10.154]) by
 soverin.net (Postfix) with ESMTPSA id 4jHTM20Cb3z1Hb1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 01 Nov 2026 09:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=izzo.pro; s=soverin;
 t=1793523630; bh=tDHuOCd4iolJOZ6pK5ZD9FwJJfOOYSbtNvVcN0nHvEw=;
 h=Date:To:Subject:From:From;
 b=kZ43Zk8yDicz2g4UsSdtw+0byLhtDG1vJCArknJxeifWYVvSGDv3CNBliWsOnCqVq
 5JEuW8uWsUSnKMF21IhCzbX90WO5Z3VB1lPfnVAhLiXWNVaJfJjEqiqlmGgsqUfS4U
 QbyI4hLgi9mV3QFNDYf5OfCnIcaFgGx0MhhWSfOV1PpIMMzkYgzg7nOk4H3m6m+VMa
 78bbs9ajjXtmGzYoxyt5dom1tV6B4UWAe2+SZ6Qqqixf0tt3F25GG1YRDCrS/CV/N8
 g1V6F6wzgNXP1rn9T6mKIXLaanuFRHiLKdkA4kEjJsJHOX7DYlBX38SLUHC5gTpsvV
 wFnduDjPo0qWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=izzo.pro; s=soverin1; 
 t=1793523630;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=GbwqZZ7XWtPrAl/bhtA/8lzVvVD5LPA1qK2TszjVfmc=;
 b=bmKaie9Whz0W0WxcQDglRZhEGSH6E/RX/FNcW9GdM+/4/T/Cng+uXmDvCLwLgcqV9YoLxC
 OTl/R2gYy58kBf9iqFZS9fPqIQdlWEpjAV3siwe2Hk1Tz99KDsp33CJROjLqj5mhtkJRHe
 aICjuxDdXy85edkWROi4CgDwJRlBVF6XMe57QRE5f0d3vN06Tij0epPuJvaZCoBULkUSkK
 121j9X+tk9KzWezPkEHdLjxeWvQmTGj8sAZJaLHHFtouuqHKi/qoUBgxehW4Gki+C7l9dr
 D5usK7rOeZvGS2CEGqVLhMHNnRxgtrmSIXKerWtG8ZWtAjWQ9pC7UxiUlznRxw==
X-CM-Envelope: MS4xfH/GTLhoJ2UVX/qJO4kxoyirvZCRNM0vXL7fgl20+10qzq31akFGISSY5jpe4b5YZK14Z9OFf/ihj/GP16MpX3aGKX9/71sSFkepc8srHg9OCIzEE7bN
 sVfGwayJa5055C2+rIJZnTkuZ5ThXY9/rpgQ2n1zZiJA5+NyK6E0EY4vWOfgKXAubpVvhVZRLex79P5NC3be2+2Pfue6UeatDyZ5amDFqW2Fh+y6Gen9mK2Y
X-Soverin-Id: 01a19656-bfb0-7ee7-8eaa-bb1ee91c27fd
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Date: Sun, 01 Nov 2026 10:00:29 +0100
Message-Id: <DMJR2CYAC8C3.36W5SE92C5OL4@izzo.pro>
To: <linux-f2fs-devel@lists.sourceforge.net>
X-Spampanel-Class: ham
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xNRje-000000008N4-1swF
Subject: [f2fs-dev] update_data_blkaddr assert during resize.f2fs in Nura
 initramfs
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
From: Federico Amedeo Izzo via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Federico Amedeo Izzo <federico@izzo.pro>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,T_PDS_PRO_TLD autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello,

I am a member of Nura (formerly postmarketOS), a Linux distribution for mobile
devices. Our system optionally supports F2FS as filesystem; developers can
enable it instead of the default ext4 when building an image for their device.
I noticed a regression on fsck.f2fs/resize.f2fs from f2fs-tools 1.17.0
resulting in a corrupted filesystem making impossible to boot a fresh Nura F2FS
installation.

Our setup to install Nura on Android devices is to create a small image 
containing a GPT table, a FAT32 EFI boot partition and a ext4/F2FS root
partition. This image is flashed on the userdata partition using fastboot and
gets resized by the initramfs during the first boot to make the rootfs use all 
the available space in the userdata partition.

The fsck or resize operation is corrupting the filesystem, resulting in an
assert during update_data_blkaddr(). See the commands we use in the Nura
initramfs and the corresponding logs at the bottom of this message.

Note: We recently introduced the `-F` option to run the resize
non-interactively, as we run it in the initramfs during boot as described above.

I hope you can help us solve this issue and restore the F2FS functionality on
new installations. I am available for making further tests or investigations.

Thank you very much,
Federico Amedeo Izzo

### Command: fsck.f2fs -p /dev/loop0p2
Info: Use default preen mode
Info: MKFS version
  "Linux version 7.2.11-arch1-1 (linux@archlinux) (gcc (GCC) 16.2.1 20260810, GNU ld (GNU Binutils) 2.47) #1 SMP PREEMPT_DYNAMIC Fri, 16 Oct 2026 00:28:58 +0000"
Info: FSCK version
  from "Linux version 7.2.11-arch1-1 (linux@archlinux) (gcc (GCC) 16.2.1 20260810, GNU ld (GNU Binutils) 2.47) #1 SMP PREEMPT_DYNAMIC Fri, 16 Oct 2026 00:28:58 +0000"
    to "Linux version 7.2.9 (pmos@build) (Alpine clang version 23.1.3, LLD 23.1.3) #3-postmarketos-qcom-sc7280 SMP PREEMPT Sat Oct 17 01:53:13 UTC "
Info: superblock features = 828 :  extra_attr inode_checksum sb_checksum
Info: superblock encrypt level = 0, salt = 00000000000000000000000000000000
Info: Segments per section = 1
Info: Sections per zone = 1
Info: total FS sectors = 700160 (2735 MB)
Info: CKPT version = 39bb7788
Info: Casefold: linear_lookup [enable]
Info: checkpoint state = 145 :  trimmed crc compacted_summary unmount
Info: No error was reported

### Command: resize.f2fs -F /dev/loop0p2
Info: Force to resize
Info: MKFS version
  "Linux version 7.2.11-arch1-1 (linux@archlinux) (gcc (GCC) 16.2.1 20260810, GNU ld (GNU Binutils) 2.47) #1 SMP PREEMPT_DYNAMIC Fri, 16 Oct 2026 00:28:58 +0000"
Info: FSCK version
  from "Linux version 7.2.11-arch1-1 (linux@archlinux) (gcc (GCC) 16.2.1 20260810, GNU ld (GNU Binutils) 2.47) #1 SMP PREEMPT_DYNAMIC Fri, 16 Oct 2026 00:28:58 +0000"
    to "Linux version 7.2.9 (pmos@build) (Alpine clang version 23.1.3, LLD 23.1.3) #3-postmarketos-qcom-sc7280 SMP PREEMPT Sat Oct 17 01:53:13 UTC "
Info: superblock features = 828 :  extra_attr inode_checksum sb_checksum
Info: superblock encrypt level = 0, salt = 00000000000000000000000000000000
Info: Segments per section = 1
Info: Sections per zone = 1
Info: total FS sectors = 700160 (2735 MB)
Info: CKPT version = 39bb7788
Info: reszie wanted target FS sectors = 55974510 (218650 MB)
Info: flush_journal_entries() n_nats: 25, n_sits: 0
Info: Duplicate valid checkpoint to mirror position 1024 -> 512
Info: Write valid nat_bits in checkpoint
Info: write_checkpoint() cur_cp:1
Not enough space to migrate blocksTry to do defragement: Skip
[update_data_blkaddr:2527] NAT and SIT is inconsistent: ino: 3871, nid: 3871, blkaddr: 838754, segtype: 0[ASSERT] (update_data_blkaddr:2529) 0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
