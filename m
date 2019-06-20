Return-Path: <SRS0=6WL8=UT=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F077C48BE6
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 20 Jun 2019 20:53:54 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4F542085A;
	Thu, 20 Jun 2019 20:53:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="WqUUetzn";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="kTHEfHQ3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lnZsaHaX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4F542085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1he446-0000fa-Mn; Thu, 20 Jun 2019 20:53:50 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1he444-0000f9-Hp
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 20 Jun 2019 20:53:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=eeDoAFUJ+dj2T1j56lDGn2RIHb0v/e0XqQHBpr2jzd0=; b=WqUUetznr+SE1VgDsj7tRWXwRH
 z2MwzBtFzBFFPH/Jzpa+P5VGPRjdXyYVdH/s8aSqBWZXTaPTFcBTP/v5Mo5bnGw8n+J8L/CDbkYnd
 yzN11Ke/iX6KOuL2uaRBI+I3f+TapBd46k0/Zw47i/+dQXKb5M0bw9sHO1DLwkYxfVXc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=eeDoAFUJ+dj2T1j56lDGn2RIHb0v/e0XqQHBpr2jzd0=; b=kTHEfHQ3ADDbqOvnn1qeIVOab1
 u1sqlW8Zl8bljhjOFH0OaFIiT2TBXMT3SZ1xXawtfvNJk+skmYQMV8y0XwBoN6lVteSTHeHxnaCk9
 QBy4tDDecG8V/jpzvxCjR/0GdAE6tBGvssQyXY1kJYRLj0jNZDKRUqn2ov9RzPIMBzVA=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1he445-006XWR-90
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 20 Jun 2019 20:53:51 +0000
Received: from ebiggers-linuxstation.mtv.corp.google.com (unknown
 [104.132.1.77])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 3A4BA208CA;
 Thu, 20 Jun 2019 20:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1561064023;
 bh=lz5JpkYzmpTTBeM2ob3LBdeWeHwnBEIFX+pUx3P6ez4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=lnZsaHaXbNKvT+ATrs0zKxozNjZv/Hg/rnmBxsdpINoJfiHKbEVWuedfwkHFjDO3b
 v92007qO4SnUWdrLWatHtt/yrEZVNIwKm9s87Rw6HQVOwj2doilz8oHoV+9DZcPdIK
 Algk5EzI33ZCevsITsLQRzwIdOKQKNQsJTuv70gY=
From: Eric Biggers <ebiggers@kernel.org>
To: linux-fscrypt@vger.kernel.org
Date: Thu, 20 Jun 2019 13:50:31 -0700
Message-Id: <20190620205043.64350-5-ebiggers@kernel.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
In-Reply-To: <20190620205043.64350-1-ebiggers@kernel.org>
References: <20190620205043.64350-1-ebiggers@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1he445-006XWR-90
Subject: [f2fs-dev] [PATCH v5 04/16] fs: uapi: define verity bit for
 FS_IOC_GETFLAGS
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
Cc: "Theodore Y . Ts'o" <tytso@mit.edu>,
 "Darrick J . Wong" <darrick.wong@oracle.com>, linux-api@vger.kernel.org,
 Dave Chinner <david@fromorbit.com>, linux-f2fs-devel@lists.sourceforge.net,
 linux-fsdevel@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-integrity@vger.kernel.org, linux-ext4@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>, Christoph Hellwig <hch@lst.de>,
 Victor Hsieh <victorhsieh@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Eric Biggers <ebiggers@google.com>

Add FS_VERITY_FL to the flags for FS_IOC_GETFLAGS, so that applications
can easily determine whether a file is a verity file at the same time as
they're checking other file flags.  This flag will be gettable only;
FS_IOC_SETFLAGS won't allow setting it, since an ioctl must be used
instead to provide more parameters.

This flag matches the on-disk bit that was already allocated for ext4.

Reviewed-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 include/uapi/linux/fs.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index 59c71fa8c553a3..df261b7e0587ed 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -306,6 +306,7 @@ struct fscrypt_key {
 #define FS_TOPDIR_FL			0x00020000 /* Top of directory hierarchies*/
 #define FS_HUGE_FILE_FL			0x00040000 /* Reserved for ext4 */
 #define FS_EXTENT_FL			0x00080000 /* Extents */
+#define FS_VERITY_FL			0x00100000 /* Verity protected inode */
 #define FS_EA_INODE_FL			0x00200000 /* Inode used for large EA */
 #define FS_EOFBLOCKS_FL			0x00400000 /* Reserved for ext4 */
 #define FS_NOCOW_FL			0x00800000 /* Do not cow file */
-- 
2.22.0.410.gd8fdbe21b5-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
