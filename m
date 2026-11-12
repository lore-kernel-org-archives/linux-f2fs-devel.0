Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E42606A336
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 12 Nov 2026 21:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=DLZRm9vv;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=YJ3mHjID;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=BRjULXZS;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=F6Hu1HS8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=W6m/ATICWKQTEKJr2pAKTKIdYSZbyKPgxLtC4W6Vxdo=; b=DLZRm9vvJU2y/owvLamthGckUj
	ARsvXIN67jUCzOzvuy6SFod8ziJ1uAFzW8E4uUAv995c7aSGrZHnDJ+UCn7HKVbec7r3QSEmUJ5rg
	i6JvNQsT7UvXIpFOBxGn0xpYj1ySpe5b57mdbI7LYZ99q7LeRbAlMvTdgEYToo7/jUlM=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xRca0-000000001i4-2flA;
	Thu, 12 Nov 2026 21:43:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <dennylin0707@gmail.com>) id 1xRcZr-000000001hs-2S4C
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 21:43:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=M6fq7p14U+tYgRDdS9W71/l4cxPwKXbIldK0rYG2pfM=; b=YJ3mHjIDC118N3hC7il7bjaych
 cMARG+n6mdGPSjd38ycBdUGSqf3JvuFHAafr1F3mB/XClJJFFoe0shvsZKHdyufvzBh9p6BFL5eyu
 iwBNVn2vCnzBELHC8hGF4T7qD+5NoOsHUrpLHteajBnygDUO3ooQkskmte2SVYQ0/Pm0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=M6fq7p14U+tYgRDdS9W71/l4cxPwKXbIldK0rYG2pfM=; b=BRjULXZSQLUU5MtbLKUbZoLwkg
 mIn11UosZS3G9fYLIMTrFyjl1Xc19t9FsmGhjTjoJa1guj6S9lvASAg8k5cL8Xan8S8/ObUbYK7mY
 jen7E6pRSbWipCHLzghxh+PWFWwWDWcmJ6nsQEUmAcEsok3392krO33syFsrAuqtiau8=;
Received: from mail-dy2-f9.google.com ([74.125.229.9])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xRcZq-0000000014l-06VS
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 21:43:27 +0000
Received: by mail-dy2-f9.google.com with SMTP id
 5a478bee46e88-377157fde7bso146780eec.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 12 Nov 2026 13:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794519800; x=1795124600; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=M6fq7p14U+tYgRDdS9W71/l4cxPwKXbIldK0rYG2pfM=;
 b=F6Hu1HS8JUAu0OWRH2JEWTcr1HItb2ERLu3iYlTi8q0614cK9Liscq6DGGp3lwRXJu
 vXfdEguTTN+LR8yp6Nz5YdcBdXx/F5chLY7XkausA5vV3wkQklLw0cocVf3NB2kNtPT1
 xvtDmeP49ZDqUhOjY54pSAee3PKB6iVmm3lWdXd418brsvIt1xrUKaSl8Q72G4tJ3zgl
 pNa3AmPwX6lZSj+FpcdZbOVmsofpoyuk/RXqa+RW5G9N7/ECEHgCRYK2OCtn7PAvWAQ3
 /LigSJ2O17KKkC5amzntyLMUSBlQJRrl5UMscbCLUOxVjDqkSi4cHF6diG02j0W1DoLv
 WgwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794519800; x=1795124600;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=M6fq7p14U+tYgRDdS9W71/l4cxPwKXbIldK0rYG2pfM=;
 b=P7sJqYiz/hbI/vlMliPsrPv1LeiNQc//nFjw/WVdXFgo5vU5UMS4LdkS/VKCOnjeQr
 OLMllOe4Tzp4f7gWTI/FKaAQiJvlrjpwwgf+UU+pZnChSIqX65JNaYuuutOoB2PtnRKx
 qOAU2K/VHHyI/J5GE6KsGFs95cMBi3j1snhRLvW0+x1xJBeHLb6y78c70LEtjHaE91A7
 qHtTc72syKLdx6THvryq2lr8qGbCARJvV56SSLIRyGaRv+DYag2GSkhj8gl53VC4rdEj
 3lZiT+nA+ce89Cr5WmKHdOoUVh0YtwkSWgx2umv8VwJ8ZxPjGHJNxlAXcNPxr/yKkY0H
 nu4g==
X-Forwarded-Encrypted: i=1;
 AL+hErFsikVQCVtkFa1wpAKf8J47yLY0igqZiFOU6mLI+X7zd2NvZMZOJF5QWnLSR/cHIUUZcZERSkF5ICOQ2BsMoP2S@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+LxNNnW+C4DCZzpRLsUMmzRfIDfc/eCBZoyl/R+8Yilnd7crVi
 GEOLWRW5min8wLwVcT7FJhbVAA6ISUoLvpOJ+Z+ZnQ1EHC6Dkxg0nqHC
X-Gm-Gg: AYBFou3OXJAjfRGN3oZQKHqBtjq1Mhz4agX1e+e3qUx2DoczXj2A6ZLFNFS5bjECXGo
 oQrQJyd7Hc0XkJZF6KwQaCK9asddysocY9lebrzNP/WUcrH5ktCTjbXSg1dYgQugf6ag8zuLYLg
 qKY9C7pjXFIJRlFMkMPKQmv2gKYYCdHzpDRzxqSg/OEWVgqFouFP9W8aq0rfdUefatSeeqcI7sw
 hX8Cyv/pdainCg9UKxenh0HtFFjlKP8FbMn5ga4fmivi5ozuXkFSGdaL67RNBOHjaul5TvnbiwP
 cPBq6zf3V11AEA4fVgslnaLpxb0ZYkTAG1UwZ7r21BCgdo8/hXv8k7lcWw9w0z0/qEdHUbh1DTW
 1qPYn5oQ8StuaE6AOx9u8ZA7Sp4jjQHAZcjFu9FQLjPnycSECg0VfjGMPB539UaSxCQAHSc39sE
 lwDVhz5Lbm2DpDAG2cGratfx2qY4cUFr/tvc6oPiqisLvEU5Zu1Je5oYhBsSgrKdouFJWhVhDqd
 GNPdxHqTLdjtt6XtnPU8cpL/oAVPbnP10oUOtGkHW4lMudAjSUFWj3wgdK0yDL2OzZLvy7lf5ae
 fvf/5059M3gZXMSiqj4wZTUGgAYc+mAsXjGSZfnySW6PYCANzIWIpRwd+D5FdI4XzyyWVdiSFKV
 115B8NYDvQbjvExYoNcz+rK4UUljj3hUeCNl1KA==
X-Received: by 2002:a05:7301:f2b:b0:35d:2633:ff79 with SMTP id
 5a478bee46e88-37968d8b5c6mr434742eec.40.1794519800357; 
 Thu, 12 Nov 2026 13:43:20 -0800 (PST)
Received: from localhost.localdomain ([98.148.34.5])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-37956bad134sm1194466eec.27.2026.11.12.13.43.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 13:43:19 -0800 (PST)
From: Hungyu Lin <dennylin0707@gmail.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Thu, 12 Nov 2026 21:43:01 +0000
Message-ID: <20261112214303.16198-3-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261112214303.16198-1-dennylin0707@gmail.com>
References: <20261112214303.16198-1-dennylin0707@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 0.1 (/)
X-Headers-End: 1xRcZq-0000000014l-06VS
Subject: [f2fs-dev] [PATCH v2 2/4] f2fs: require write permission for
 F2FS_IOC_RELEASE_COMPRESS_BLOCKS
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: linux-kernel@vger.kernel.org, dennylin0707@gmail.com, daehojeong@google.com,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

F2FS_IOC_RELEASE_COMPRESS_BLOCKS does not check who the caller is, so
any user who can open a compressed file, even read-only, can release
its compressed blocks. After that, writes to the file fail with -EPERM
until the blocks are reserved again or the file is truncated to zero.

Require write permission on the inode. inode_permission() does not
depend on how the file was opened, so a caller with write permission
can still release the blocks through a read-only file descriptor, as
f2fs_io and Android do.

Fixes: ef8d563f184e ("f2fs: introduce F2FS_IOC_RELEASE_COMPRESS_BLOCKS")
Suggested-by: Chao Yu <chao@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 fs/f2fs/file.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index cfd24a5fa271..93f892b11915 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -4238,6 +4238,9 @@ static int f2fs_release_compress_blocks(struct file *filp, unsigned long arg)
 	if (f2fs_readonly(sbi->sb))
 		return -EROFS;
 
+	if (inode_permission(file_mnt_idmap(filp), inode, MAY_WRITE))
+		return -EACCES;
+
 	ret = mnt_want_write_file(filp);
 	if (ret)
 		return ret;
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
