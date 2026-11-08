Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B080E606A320
	for <linux-f2fs-devel@archiver.kernel.org>; Sun,  8 Nov 2026 07:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=NcXtwWP2;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=IZAGgvRz;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=auwkdj5C;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=D9BGNbgl
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Unsubscribe-Post:List-Owner;
	bh=dnAUNbCgIdU/pWiDSICBiouBzw0zf9M7P9BQ8JdTZDE=; b=NcXtwWP2XwzeBiVOIYCULynca4
	nKN0Jy1noqkCibhn9RQyOYnTXUexJ1oOT04YbuquuAlDcFnrS1M3fFXpNKTo0OR5e7Nsg9jIHekAL
	WsJv0LxwTu+anhOar/Vux/4k67Vn4VwzxsUMpBV5wLHVTEwb5xlwcu4janL/BmEk6iZY=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xPxjF-00000000266-25tO;
	Sun, 08 Nov 2026 07:54:17 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <dennylin0707@gmail.com>) id 1xPxjD-0000000024l-3H3B
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 08 Nov 2026 07:54:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8tBhA04OZW48u2CYSoRKHfkBmCLrM00ptAagGQEc3QE=; b=IZAGgvRzAPW5ta/UOxjfHOK6FH
 nfAzbDK5HxnLW6xypSZTP9iNxT/bOb562Gj0O6xfDpwOgy1xaM3Cakp+8eAsIBL/MbxLjwAs6jjvV
 OykOIkDtv2IHTuZ540wTNtZZ/hty0k+XE2mChZHbb5pNpjpQvFjKG2sTLRwKzxXtlatc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8tBhA04OZW48u2CYSoRKHfkBmCLrM00ptAagGQEc3QE=; b=auwkdj5Cxi+1PtBiBs5wUBQMjN
 n1gccj95II0cE2iaYdzeRNoMDErA36o4ibuVy12+EnOvbrINbE+xa9YKUgBOT1beL8XYmnfW9jvw8
 TLS95l8x7pQumZv/Hwgc0XXHbrqAyrcfUSPRbc2uTR7fiKjEJ5U3YUKUksGHS/43WO1Y=;
Received: from mail-dy2-f5.google.com ([74.125.229.5])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xPxjD-000000003Kk-1dgU
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 08 Nov 2026 07:54:15 +0000
Received: by mail-dy2-f5.google.com with SMTP id
 5a478bee46e88-36f936424f2so117433eec.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 07 Nov 2026 23:54:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794124450; x=1794729250; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=8tBhA04OZW48u2CYSoRKHfkBmCLrM00ptAagGQEc3QE=;
 b=D9BGNbglrAeCL0CKVWSrls9IbPNdL5kFdIUoYCVV/bI3marSqaG72LZ0LWFjMISn3h
 jW1BIHxmChq4CVx9/01Ammmok2oq0ZtEqaG15WffWEyk3LDXt6QlG2RG7y240cXJ1FRL
 U/CA9rZ0q3AQ7PvVWvIzcDhWHUPis4K5gQ+z9xKEVUcNoRmpeAeHzmtKg+NWIxqYX+N+
 uTuPc4dlTzl/JNu5ZmxQJY6GpSYUOCYPj2hxsJxSGSuQsezBZlt2iRwkeJrwJQ/mq+NU
 ad8EUTiToCgNr0KkA3/K3g4EdScHFu2A2BA5M41uvBxZc+3wBxRUuXG99FwmoJ9BnBXJ
 zUnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794124450; x=1794729250;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8tBhA04OZW48u2CYSoRKHfkBmCLrM00ptAagGQEc3QE=;
 b=xE4w6kgvFSQveTJVPEx/Rc6Bury3IOg2MRYBcF+buFdhMsppk/9iiA8qSnlFLyByn1
 i6/Ws0KBfToNz5sQPXz678cqNLnntg11Xbs5EgH1xz/a4fCJgE9L3Dc7ouWDIEeUBDMP
 pcFDypw1X/X+O31jfC4T7f5FxSM3OmTXVfK9PHL3obl3P/PdVSkJ67Fh/DvVEOP/Ayr5
 puQuTE560hUCgXOTUCSMr0xuWsi0euyvFAUpFuE/TChZEnqHG2P0eyQnvFxTsUu+xlwj
 6U5ApXjjfQKcHH+yHeLQwfkLyNmDZDSx08bLIwHPY2IPbXJCbqw45Vo6PCLu+plpWTza
 el3Q==
X-Gm-Message-State: APuU4Z+EsCzs7Ia7q/nBTHL3WVjTSpSg+0zk8syq41U4Bef7W1RNuBeu
 2QiQlYjb/F62C4O8hBLxqg43/cnod/DkCBOE/lZJKQ08YSzPvBBK4htK
X-Gm-Gg: AYBFou0ectBCVr3eY2i+2LS66JfmV+UNtHKm01pHAYkGwGjYtH5f0+ZENXyf8DTcDcg
 NPfQUHbObGJ5DyIXt58FDCFxXkG/E11sDtJtU+njZQiTpkST7XWH2PW9tNQjfJ801pTqcuNcZGr
 +yJ2JM9ZcCQ9E0B4YkI/vpikwfr3s4XJjQHIypxXBOQ84NEEezo3tINBTsgLpofTVv1XU2QInJm
 kpXRHTjFqgB0LACDSYNYKPEb91IRsVmWG6yapwuS5tGNK+c9MdyhDlK1zN+valiWDQ7Y1sbZbdt
 OZvY80Dw4P8pVedW6nEs/7MlhtrDWpL1fJiP0KdZZjLipA0tRmCkj5UkswPaL0XKz9y3uVcoHrG
 cq+Y96EsvlPmRb+1bLWG2eXV9uHoBYmUpuBcqLOWY/nMl+wPCeRdlOqfviQSzXwPvebFzp7jobb
 mpfn88PnjLM3JEQt28wfevuG5HHQ7Yuk4jnANwPJvhexeGYWowhjYfXTTiHi2u0p2+iQ9hA+V80
 4dIFTa5gJb3nH1TpFJyYewYja2BlVE7nO2Jkd98S31uUuWnitw0Hfy6XychTfQpyS65gd1rlw0B
 rIg1Vg7qrURp7N/JLWOUJzoZaWQKJBjW+audc390qjm1OtgKLNPXKuQ0gs5pf+rzulaikEDCAK+
 y97D47l8KCRfqmaXJLOf6uVgSamyZWKfrCdwxjA==
X-Received: by 2002:a05:7301:d80e:10b0:36a:50ec:db3f with SMTP id
 5a478bee46e88-372575c557amr2132822eec.7.1794124449668; 
 Sat, 07 Nov 2026 23:54:09 -0800 (PST)
Received: from localhost.localdomain ([98.148.34.5])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-37265ff3415sm3310760eec.18.2026.11.07.23.54.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Nov 2026 23:54:09 -0800 (PST)
From: Hungyu Lin <dennylin0707@gmail.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Sun,  8 Nov 2026 07:53:57 +0000
Message-ID: <20261108075357.43331-1-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 0.1 (/)
X-Headers-End: 1xPxjD-000000003Kk-1dgU
Subject: [f2fs-dev] [PATCH] f2fs: require CAP_SYS_ADMIN for fallocate on
 pinned files
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: dennylin0707@gmail.com, linux-kernel@vger.kernel.org,
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

fallocate() on a pinned file allocates blocks without zeroing them, so
reading the file returns whatever the blocks held before.
Documentation/filesystems/f2fs.rst describes this as "zero or random
data". Commit cad3836f9eb2 ("f2fs: allocate blocks for pinned file")
added this while F2FS_IOC_SET_PIN_FILE required CAP_SYS_ADMIN, but
commit b13bdf03bb80 ("f2fs: allow all the users to pin a file") then let
any user pin a file. Since then any user can create a file, pin it,
fallocate() it and read back data of files that other users have
deleted.

Require CAP_SYS_ADMIN for fallocate() on a pinned file. The documented
use of these blocks needs write access to the block device anyway, and
Android's gsid, which creates pinned image files through libfiemap, has
CAP_SYS_ADMIN. Users without CAP_SYS_ADMIN can still pin files, but can
no longer preallocate blocks for them. fallocate() on files that are not
pinned is not affected.

Fixes: b13bdf03bb80 ("f2fs: allow all the users to pin a file")
Cc: stable@vger.kernel.org
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 fs/f2fs/file.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index e2c0f5083313..d1b52b41a1eb 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1973,6 +1973,9 @@ static int f2fs_expand_inode_data(struct inode *inode, loff_t offset,
 	block_t expanded = 0;
 	int err;
 
+	if (f2fs_is_pinned_file(inode) && !capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
 	err = inode_newsize_ok(inode, (len + offset));
 	if (err)
 		return err;
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
