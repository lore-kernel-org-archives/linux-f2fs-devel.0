Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2A4606A32A
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 17 Nov 2026 17:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=fQxzYwPS;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=fL/5Dsoa;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=IeV+Lo0O;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Krrxx646
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Unsubscribe-Post:List-Owner;
	bh=fOS3YHWEHGdvtQwmBgEWhu7IMTpb64wewiBxkUMH75s=; b=fQxzYwPSZhn7rsU38SCav8xpXI
	ySZvkej8wtqusRoK1Zz/tChV16Kv5UfvhmSDSYYjNGFSIPQb/YKFLxt6QEcq0pImKtYkd8LZ0Z9lE
	yodMPE/j/uOD9Z/R9F/VmNeaTbm6YFeYp8rHTa6Bg3rbx8aaXnxEZv+so5wMfHs7yNzk=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xTN8O-000000003at-11gK;
	Tue, 17 Nov 2026 17:38:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <dennylin0707@gmail.com>) id 1xTN8N-000000003an-1ZWw
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 17:38:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tdQG22gijaLhaWplOE+b6jkzR3mh5Eg+zc+PAvXuPiQ=; b=fL/5Dsoaxpxzz4Ja38m3MuSIY7
 9Pmw9pNtA3le99TEtPbzOCTKl+5dhnL5HziUcYmtJ25moPJO567z/vhKHlEDoK1dPNCKBPWQTU8rN
 4lmMRq7z5Ccw9F8gAt4ObBic1BzdAKL+XOlR6x2ziQCVOYH4zH2xOWXE0mMguJ3o2KGo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tdQG22gijaLhaWplOE+b6jkzR3mh5Eg+zc+PAvXuPiQ=; b=IeV+Lo0OslbkQYvtP0px5+4J+D
 at+wsHz1U3TS8J3AlInbeLJE7/c46d+Z0QugUU4rLqm9LOas5MSlu0oA1qkH8HuJVbZEEyt7/wt9W
 3JjJfnxsGTHwd4OR1Tp6FReQA3WvJ7DGjbP25ehU7/LuVg04MRYlYQBGnPKnoUkYdluQ=;
Received: from mail-dl2-f9.google.com ([74.125.229.137])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xTN8M-00000000085-44aS
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 17:38:19 +0000
Received: by mail-dl2-f9.google.com with SMTP id
 a92af1059eb24-19305bcb6d5so10524c88.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 17 Nov 2026 09:38:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794937093; x=1795541893; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=tdQG22gijaLhaWplOE+b6jkzR3mh5Eg+zc+PAvXuPiQ=;
 b=Krrxx646jyYei/TLD/6Fitpkrr0uxm9cYeMLyyP+XpYaUEXq2ksibUzQelKGNiHKB2
 QP0oFW6SGQzEE8gTeHS9MOKDHHAGM+L6T83g4+oxyv0Gwu13QoS58RjVWAwAYOMLXAJX
 thJRypMnrGy51PY9uvYAaw6Rk3q+ASv/aLXuHEPNYZIS1kUH7om1SIgLzjlJPgO0LVyg
 B3naninIdACqSjiGfQcl8sEzEibXbcYsJUtq65EWCbDWc7SM7J6zY/9wp9o75soBbedp
 +Rngo450LCMqYjWPxSOmrtQpzR3pjeW/lmrDvDBOQ18SVtWUlk50hDUwxxk/UU4W57gy
 J6CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794937093; x=1795541893;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tdQG22gijaLhaWplOE+b6jkzR3mh5Eg+zc+PAvXuPiQ=;
 b=1JJCb6UjdOjP/PkABhQdijC8Vuco26+pax27Ccl5GwBNSDwddl0kIxNKG+DdCBbNET
 xjpiVn36E8ZCjp2+3cz0xD+H1ZFbOKFr08eI3S2+6KtvAzFSq5Mpc156Ufx8XA9aDC9/
 5W5LtLobtwO9ydH3pKJ8qWI9cmg2BdgWxGRZr76r3IvXmU2hM6Bvq2wIPerjCNpHwRPH
 ISGl2zL0ocTobtwFMu1uFcyH5yTqNumfZeWy9xPVFnIpgFM20zhZ3CC2T0wuMWA6gcSX
 AqzzhrFu+gckszFTmYoBXzaPcF4kKDlc9c2AnFes/6nhkOfdzrRGFXV+phPCFFwZRbsy
 o18g==
X-Gm-Message-State: APuU4Z9Q4qfKPMi6vhyvrEFnurM6dVz3DSaeh/73wwPSLQR0Q8cmd4nU
 RhI5+wUikrBDt5igHEQBV242Lrk0Fl77wjGmGAZCdCzr2Xy2np8TAUotVnzzDOaSGnoJ7w==
X-Gm-Gg: AYBFou0EL0O5uT4APD9O9ascFSv82N5ZJ53O7tnJzgmfiuMfLIQ5/M6IAkzuJkPVF01
 S7HdEHDrC2wFYzpShgsQJV+wqfI0nhmqI5iF2++tAzRTL0znbFXmNCnmGb5E4yBMgqKWlUAw5yW
 ukm8h5kkFlaHGYnunEGsVWmqaM10DeNOOd5FH+PkukdK6BpmYkB6ruMdJW4B0F089yK6Az9Pd8N
 1K7oku0lVIGn1sNLUIgFo0bsgxaOe46GCWdzzFLcCPCSBrtroGCGDJ3qopFfDyNazxD324gu5Z8
 nT5KPhpxryIx9vjmTKPekVqVmraTEsPWw4/po08RNCWfEjkalhy+paxFRKaz2RA4l/hno/zmWGS
 e7MQW24sTK20C8zuF/rPURdrXMkB6Eosx8ntq0UlxTL88I3VMyFjRZjg5x6IneGe6ONnemAKK0H
 W/qR4dilWC7jf1Qxafbjxmxb8DyL8zqL29GHVpsyWpZKG5X1w65jDzaKqs92OG3VMht3W1Lf23t
 tdldvdFBHT6OB0gkvOvduGc6Y4t9A392URop07ubB3RS8W8zxdbB+nwTySFMlI+4L95DVqsIY3i
 4ZTTfxT8IRIYX9MHBTjk8i6VylvFS9mfDLS1whLz2WP5ws9ieUrJ8/1WAiYEH5E8aYAnwOZ+XaJ
 TAsdK7xPmChomKje7wJunLzhE9h6kSSrlOX0bKQ==
X-Received: by 2002:a05:7022:1702:b0:1b5:227:7d1f with SMTP id
 a92af1059eb24-1b543cc6913mr216962c88.11.1794937093151; 
 Tue, 17 Nov 2026 09:38:13 -0800 (PST)
Received: from localhost.localdomain ([98.148.34.5])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b50319d40asm43523768c88.11.2026.11.17.09.38.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 09:38:12 -0800 (PST)
From: Hungyu Lin <dennylin0707@gmail.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Tue, 17 Nov 2026 17:37:57 +0000
Message-ID: <20261117173757.15066-1-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 0.1 (/)
X-Headers-End: 1xTN8M-00000000085-44aS
Subject: [f2fs-dev] [PATCH] f2fs: reject immutable and append-only files in
 move range
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

F2FS_IOC_MOVE_RANGE only checks that both files are open for writing. It
does not look at the inode flags, so it replaces blocks of the
destination file and punches blocks out of the source file even if the
file is append-only or immutable.

An append-only file can be opened for writing with O_APPEND, so a user
with write permission on such a file can overwrite or remove the data
that is already there, which ftruncate() and fallocate() do not allow.
For an immutable file the same works through a file descriptor that was
opened for writing before the flag was set, although f2fs_write_checks()
refuses writes through it.

Return -EPERM if either file is immutable or append-only.

Fixes: 4dd6f977fc77 ("f2fs: support an ioctl to move a range of data blocks")
Cc: stable@kernel.org
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 fs/f2fs/file.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index e2c0f5083313..9cf733954522 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3265,6 +3265,12 @@ static int f2fs_move_file_range(struct file *file_in, loff_t pos_in,
 			goto out;
 	}
 
+	if (IS_IMMUTABLE(src) || IS_APPEND(src) ||
+		IS_IMMUTABLE(dst) || IS_APPEND(dst)) {
+		ret = -EPERM;
+		goto out_unlock;
+	}
+
 	if (f2fs_compressed_file(src) || f2fs_compressed_file(dst) ||
 		f2fs_is_pinned_file(src) || f2fs_is_pinned_file(dst)) {
 		ret = -EOPNOTSUPP;
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
