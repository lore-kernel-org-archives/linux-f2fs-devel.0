Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4572FC55838
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  6 Aug 2026 06:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ysOqrc1Ll5KFlHkJc6eFOCQU7XRjkDTrOA67ojLxZUI=; b=SfpufBX90Xr6pxlMzNACd8+KTE
	IxDvTWDewlq5sZhILbrr3D3mHYwOVekU0SBzltEFwUARUjnBleJdjuU6QpaPOEb7Gui7yLUOFjMrM
	BIv1/22LdLiq6I0vqv9LMyVovz0VsDRH6LEC1SqddaJcde9XDtjdaSLd5rzYwO5BQMN8=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wrrQt-00045N-1U;
	Thu, 06 Aug 2026 06:18:23 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qwjhust@gmail.com>) id 1wrrQr-00045G-3w
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 06 Aug 2026 06:18:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=M8JM6V1ymmgGXeBCeCu5VkItAJJqMydVFPaZbf5Vqt0=; b=GP8TCPIHo4BlBECL3TrPuHdwIE
 KZY/+UYlB1TjCuUCivj9dd05idviAib3LklT6g8U3GjPlDqidrFOCuC0hEa0hRXhRMc9DuGJtOc7o
 UTCmeg6VTF2M+JOBPgoja3YvX/wsEQ+Oq8AkB5OUyV5sFS/ahA0hl479s1QaSFXpo14E=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=M8JM6V1ymmgGXeBCeCu5VkItAJJqMydVFPaZbf5Vqt0=; b=Y
 DavfflFZY1RYw6nQsgApjpevUmBwLDSa+SbbA8m+e9scScW9k4OBDNSmzdTnH2OI/V/6+bzq1P3Im
 uyZ8DlzgpktsyWJu+ZDUZz8mcrrY5czouMZ09WwSc0G4e/FrD+db+aI+ckbW9/JZdlTxpfz5h2BhT
 grT66C2D5PB5CsBA=;
Received: from mail-pl1-f175.google.com ([209.85.214.175])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wrrQr-0003Zd-DU for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 06 Aug 2026 06:18:21 +0000
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-2cfbbdfa60bso17229855ad.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 05 Aug 2026 23:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785997096; x=1786601896; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=M8JM6V1ymmgGXeBCeCu5VkItAJJqMydVFPaZbf5Vqt0=;
 b=MFuH2K56tOZqlOjGo96owv5klOuYji8L8n2R4nZHIt2DEfZWg8gWlrGG6/3+Y6cYDZ
 VSKwyaklWUOnk7vri4XrIDHY+2a/zqrfOU9UOeyvDPmPIOL3Bgk/d/9GPegX71qe1r4H
 MduRxghjAslj5PdaaqCcbpyPMO8QccJaaw9ti44yrfui5DZOLqR4cC0myfONWxG2stAi
 +6FyeFmYgIHLQyeLWndZE1F7Iuh0PBRaSdvSCZ+QrrqgRzGPVxJObmrOgz1m6QwBJCAr
 wtiLljTOnmtpzdZXCFZxwzDy1oNlB/ZWCN5RNs7OzePv+raDktGhFAWW01jN+q/AZ30M
 sBow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785997096; x=1786601896;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=M8JM6V1ymmgGXeBCeCu5VkItAJJqMydVFPaZbf5Vqt0=;
 b=cKFjVMoVdbu+NQ4zdTRTLIQw69VWu2hbLZcw7KfZfYM5WgZSD5UTwOcUF90CFSWp4f
 eMwX+ZTq0mPWt99IUmV1ZxdNMvKHWw8HNL/CqDbUqgv8pZLvgF1JNbWtwyb3jlmOg304
 IO6Fma9bGEEotYK3JMonfO+wP5RxyFzS6GOAYbpKjFMGvCjiYZhLSrsxyZyQbxhjH1kt
 F5b27XGTdF1/G0btLjXwNPJHQm1q+/Fdw8Yu5xyNE7jeo9JfMA+y3C3laxv4PPWW2WvE
 m0CLHmFiKYi1uW9FWyqi4UbNOSvCGUXKYi2+4PY89EjU771RvlDyCEH6iJbg9dW5egWk
 uFxQ==
X-Gm-Message-State: AOJu0YydVE4SYWOaiO9VcHJs8gKQ8/HhA8CqJexF9BOutop+9JKK8hrM
 JrtHlHwXBu/eEuItQ7k7DYIuEIrNYx1Qnl/3WOnk3FS82o7QUAsQBRDz
X-Gm-Gg: AR+sD11jJE3NiPxLysM1J/LOT8RB9DYvT/mQc18BIhrkSPYXXoYIn+6UYlLnOy5Ozt7
 4+ByCALRVlyuOADU1KKl8Y5ymgfOu15xGPvAmHlr06nrRHCqm2o4UczTFWPBdjRmhFUCCU/7MBY
 Ss1pP68OrsSOrOfx1scQ6w0Qt9flNIMIEysuUXxgh+U2jWJloIyark7eyg4KH6hUukvvSNhB9BT
 UyIc8JNZGqwVONtxOKGmlwqdLaFA+J8GtCWvE25lGOvcsY3siQtaxVz1wdJHhgsUI3HhErkN4Uf
 0icmCnjr/mjy0xi8wksAreFHhkGbnuJQAkSZY+PKP2UINu+HOtwltS6WUDyqf7QoaR3btQCiuJD
 sw5oTPzlOZoEur4pLO4oG3mX2bzXPOvSBMl3UI7SEmZh4V1fkUa2LuJ6tIcq2ham9PQaiIDwoaJ
 k0CcXuwEI/kg8iSPggOJG/o+N8m9AHA2zrNV1bFGXJRa5v2Pexawc94Z6thFv196h2lseodeIl5
 06E6zV6zeahHIiocX+mW6VgIstqWvgDOFo=
X-Received: by 2002:a17:902:d547:b0:2c9:b8b7:5d1c with SMTP id
 d9443c01a7336-2d0ca7faee4mr143840725ad.16.1785997095610; 
 Wed, 05 Aug 2026 23:18:15 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d0aa492545sm25777555ad.48.2026.08.05.23.18.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 23:18:15 -0700 (PDT)
From: Wenjie Qi <qwjhust@gmail.com>
X-Google-Original-From: Wenjie Qi <qiwenjie@xiaomi.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Thu,  6 Aug 2026 14:18:07 +0800
Message-ID: <20260806061807.3267392-1-qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Headers-End: 1wrrQr-0003Zd-DU
Subject: [f2fs-dev] [PATCH] f2fs: check cp_error before committing atomic
 writes
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
Cc: qwjhust@gmail.com, stable@kernel.org, qiwenjie@xiaomi.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

F2FS checks cp_error before entering the ioctl path, but cp_error can be
set after that and before atomic commit starts replacing blocks.

In that case, F2FS_IOC_COMMIT_ATOMIC_WRITE returns -EIO, but the current
mount can still expose the new data before remount.

Check cp_error again in f2fs_commit_atomic_write() after
filemap_write_and_wait_range() and before block replacement starts.

Fixes: 3db1de0e582c ("f2fs: change the current atomic write way")
Cc: stable@kernel.org
Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
---
 fs/f2fs/segment.c | 3 +++
 1 file changed, 3 insertions(+)

QEMU validation:
- before fix, FAULT_CHECKPOINT made COMMIT_ATOMIC_WRITE fail with -EIO,
  while the current mount still exposed the new data; after remount, the
  file reverted to the old data.
- after fix, the same fault still failed with -EIO, and both the current
  mount and the remounted filesystem kept the old data.
- no-fault smoke still committed the new data successfully and preserved it
  across remount.

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 0b706568b034..e6384dd2e916 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -408,6 +408,9 @@ int f2fs_commit_atomic_write(struct inode *inode)
 	if (err)
 		return err;
 
+	if (unlikely(f2fs_cp_error(sbi)))
+		return -EIO;
+
 	f2fs_down_write(&fi->i_gc_rwsem[WRITE]);
 	f2fs_lock_op(sbi, &lc);
 
-- 
2.43.0


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
