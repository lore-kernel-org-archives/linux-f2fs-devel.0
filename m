Return-Path: <SRS0=3PeV=4K=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2980C35671
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 22 Feb 2020 18:28:20 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E442206E2;
	Sat, 22 Feb 2020 18:28:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="RheFjj/3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="CL8DxYBE";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b="iZ2r2NW9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E442206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=xff.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1j5ZVk-0003ke-43; Sat, 22 Feb 2020 18:28:20 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <megi@xff.cz>) id 1j5ZVi-0003kV-HQ
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 22 Feb 2020 18:28:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:MIME-Version:Message-ID:Subject:To:
 From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=N1d+kDxkxZZKXdaiguNYui5X22wcHMkVXHWX8pp5u4s=; b=RheFjj/3M4Zzou8+y0mt815ooR
 WwAoicilApcBj/Wh4Gwu9UffQA0L9TfaHLFRBCxuRSDEn4xIOO6s/j1Pnck/L5HHu7WcnczI5vKjC
 bMyHrhJgEb4Rqorm4pG4l5bOMbdaNu3e1wPla8s4rC/wTLuKoKtWqD1RxezK3KaBK7bA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:MIME-Version:Message-ID:Subject:To:From:Date:Sender:Reply-To
 :Cc:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=N1d+kDxkxZZKXdaiguNYui5X22wcHMkVXHWX8pp5u4s=; b=C
 L8DxYBEBSdq9IAiTK9N98vFESOEAbKHwGi5hBTBi901SYC6WS0Vg0Sh6YfgE1DJnhFP5XCiU4BUv4
 eF8KEf63HRG2jGBimb9j5ySxSl7OXPVfeKqBIHSclbvrSOIIG7yZLrBjqnTORkoq0h/C//KO1dNOn
 ZuleGXevGnpPPcGM=;
Received: from vps.xff.cz ([195.181.215.36])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1j5ZVe-00DjEg-Uy
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 22 Feb 2020 18:28:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
 t=1582396086; bh=9kdf5yBunLYqwkkc3K/6mxUXNuNCBEMftN8hWEMHGpQ=;
 h=Date:From:To:Subject:X-My-GPG-KeyId:From;
 b=iZ2r2NW96CLVxTav9XnLKr7PVBMFn0CsOatA9/hkj+/PsBSMv8RKLP8VsfV6eXV77
 alD48Y4q91b31WIxawN2XNwBd9mOsBA5V6ZWj21kKbVcgwra5NXYX9trSiK9ZuUcF9
 8RE2t+IngxqO0mJKqKCnZrX+q2FJaW5Nxnh0evdQ=
Date: Sat, 22 Feb 2020 19:28:05 +0100
From: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
To: linux-f2fs-devel@lists.sourceforge.net
Message-ID: <20200222182805.he7zj3wqyjwy6fbs@core.my.home>
MIME-Version: 1.0
Content-Disposition: inline
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
X-Headers-End: 1j5ZVe-00DjEg-Uy
Subject: [f2fs-dev] f2fs.fsck should allow dry-run on RO mounted device
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello,

I was trying to run: fsck.f2fs --dry-run /dev/mmcblk0p2 on a RO mounted device,
and fsck refuses to run. Strace shows that it tries to open the block device
with O_EXCL even in RO mode, which will always fail if the block device
is mounted.

openat(AT_FDCWD, "/proc/mounts", O_RDONLY|O_CLOEXEC) = 3
fstat64(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
read(3, "/dev/root / f2fs ro,lazytime,rel"..., 1024) = 843
close(3)                                = 0
write(1, "Info: Mounted device!\n", 22Info: Mounted device!
) = 22
write(1, "Info: Check FS only on RO mounte"..., 41Info: Check FS only on RO mounted device
) = 41
stat64("/dev/mmcblk0p2", {st_mode=S_IFBLK|0600, st_rdev=makedev(0xb3, 0x2), ...}) = 0
openat(AT_FDCWD, "/dev/mmcblk0p2", O_RDWR|O_EXCL|O_LARGEFILE) = -1 EBUSY (Device or resource busy)
openat(AT_FDCWD, "/dev/mmcblk0p2", O_RDONLY|O_EXCL|O_LARGEFILE) = -1 EBUSY (Device or resource busy)
write(1, "\tError: Failed to open the devic"..., 35	Error: Failed to open the device!
) = 35
exit_group(-1)                          = ?
+++ exited with 255 +++


fsck.f2fs --dry-run /dev/mmcblk0p2
Info: Dry run
Info: Mounted device!
Info: Check FS only on RO mounted device
	Error: Failed to open the device!

I suggest not using O_EXCL for --dry-run check.

regards,
	Ondrej


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
