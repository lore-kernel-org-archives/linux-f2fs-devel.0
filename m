Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74823CC6B1D
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 14 Oct 2026 16:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hmBJc825zaBgKzF8jUnKcqrF7U8idqqcLMisZhgbNE0=; b=DJ/R5emuutj0AgGdS9tDbZUowc
	A7MJ1Fdg5vdxXaQ8MNoJl4CBqKLo8yhodbSt7kWIwmVuPQgvCx0CsYdveI7ijIu40xupJw2SoqsUY
	ThxCfnNR5m4yRbXleJBrdzskMN4p7RmVC8FeNT6I+3e12Hnr1YCaqgotsVB+fsnPi3Ew=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xH1iW-00068c-Cp;
	Wed, 14 Oct 2026 16:20:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <nzzhao.sigma@gmail.com>) id 1xH1iV-00068V-J8
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 14 Oct 2026 16:20:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Th0kYuHndVjuWlzBJQ0Sw7/LnyhiWEjtr++H9h1t1iM=; b=k1WCC2Y3MM+AYUt7Z7kCE/3jtr
 xulf9Fylwa4/FLDrGq9dcmEVqAEtDhTSC9W2fctf/v6TWqi0VU3iDHJcgyOovkS4+Upxb9tVo3+w1
 qgvzntCbFM6jZ3TgU1OxeGjBkMcMFPoHkdrzRdDExvmOicboTmMidADUCv/gysPao0uo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Th0kYuHndVjuWlzBJQ0Sw7/LnyhiWEjtr++H9h1t1iM=; b=iVEXGLfU5cVTTFPlsxD+2M17aA
 vCG0T+tQbGCmTgF2kUZGyo/pBovasOx0/a0bSxewke5Dn/WxTsGpBmxbF8VJQFLXG1JGxhLbMXi+y
 q2Rkk0Aeb9wYp48YJ/W5gzIlxhacOkQp2yy7A4u2zh/ZBLJXPV8+Mb+3VIOqfKgwgKY8=;
Received: from mail-pj2-f2.google.com ([74.125.227.130])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xH1iU-0003nO-Ss for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 14 Oct 2026 16:20:36 +0000
Received: by mail-pj2-f2.google.com with SMTP id
 d9443c01a7336-2e651c30dcbso14016715ad.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 14 Oct 2026 09:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791994829; x=1792599629; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Th0kYuHndVjuWlzBJQ0Sw7/LnyhiWEjtr++H9h1t1iM=;
 b=RXeVGb6E2IwY1CoJ9jkj5lq701U1VtRugwm4mLSdG8TbHE132fkUEg5izBY2VL/dLP
 TTyvG5TtlNqX8qzjIuzHema6MA1ZhE8KS8RtHt8PlUeGHCIsknPGmvlun55fllaAD9HD
 yHwBTYlLt9tb7QyU5q/QtUEOlYnWVBYjwGxM2nYdEEqKC1bWG21KKdUda7zLS8hi4ElZ
 RWCNzDgZxCuqCwkGaRNAyTtcen4fYr5I9hEdv3GKkozSy80BzRQIQnz/nORYksYGX2H1
 3AZFcGkhUfvxH7l91acoPSs1JurmotKMhBQWmiJlkNTzgIF0vVhFCu0jnWngxz8yf01Y
 Gnaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791994829; x=1792599629;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Th0kYuHndVjuWlzBJQ0Sw7/LnyhiWEjtr++H9h1t1iM=;
 b=QBpQoBgBwNAsEdF4ZOSzl3OOjq3EPL3I+A/s3/pkOOHCnV4rqikM3MwcvuuQPNLf81
 cVAZ7YDTJ4VeFJH9iglKq4Fc+xPT7++lJR26nUpYT6dAo5Xw/Ssi2K41Nzuibkw0yCk/
 zlE/hqrAE7hVt7Swd92N7lCGvS9tTa4ToIFEYQ0qRiJhu33Hyv0icCMx1MqsAY5wsh9L
 mEaYlphUbry6nXzm3JgHbmii0wir4+apYQBM2kpCJBOVS7Kq0qOlGWJX7LCtZ5AFkXTn
 ral96kWyQqGciXMgfXdpfXiG4knQZULkXaQsrymNJamVedvm5twHRE9E5394vCKEkbAR
 wO/Q==
X-Gm-Message-State: AFq9FYKRmklp2r+edQUqp0E9JCUSl5LXKv9mVIfL+C0kDz0QkLik1hmF
 hcMY+v1jnpTUmUFS2AVqWOjBRPO6AExmqNoCetfPrY3lszxNSRsceFVCxJXqG30x8T0=
X-Gm-Gg: AYBFou3sM9VhFzpTbSrrl8rOdWFRZmf9jWabCIt8qqX8dOt35hMeJHWPuR4orjG8wf1
 YdFj/C/ldQyhVBLnCMtw0BUVUtlGOHKL/hgDty1OWcAEMTZFnx4fJN3zVvg4bExTKJB61rJsfj6
 3IdztaLINZnXVc+mPtg36rkJOfaszAZM4i+DD9TpvhIjGJ+RYIoQ0ZzI06Spzj/qrFEEYuwRwT0
 tW7xK3P6629DA3DRppMRibWzRKP3+u7qxixiGdnJVkxOJCpac9WHBidHsmByfIvoB8SMpyUDZg1
 MYHu5AkliioyhXX0IlJU0c+P1G3cOGn0cj2XFPYcj5tLATJnMOFyU1XxDb4g3DTAfDgVmVd7ABZ
 wpfoXUDoOUcc30/5g+AShY6OTBWy8I0s2ZbTlyQQY7/lCzyFqNk+77Uwgz04Jru+BvoNJsBsd87
 up8cFwW548QLd4dsbfZZfnmcFl+ZQYvk4pXSX7pEF97dC4Vs4Acdl6+eOcgAiNnoCgoA5/jdPzW
 7WbZ4o08tTQddsNsjZ94TSIPP2mdkus2qfm
X-Received: by 2002:a17:903:950:b0:2e8:3e5d:b2b7 with SMTP id
 d9443c01a7336-2e842cd96d6mr148772405ad.40.1791994829050; 
 Wed, 14 Oct 2026 09:20:29 -0700 (PDT)
Received: from nzzhao-ThinkCentre-M760t.mioffice.cn ([43.224.245.179])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e841a009a7sm73076765ad.11.2026.10.14.09.20.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 09:20:28 -0700 (PDT)
From: Nanzhe Zhao <nzzhao.sigma@gmail.com>
X-Google-Original-From: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
To: linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <chao@kernel.org>
Date: Thu, 15 Oct 2026 00:19:44 +0800
Message-ID: <20261014162025.3833314-1-zhaonanzhe@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014064445.2835813-6-zhaonanzhe@xiaomi.com>
References: <20261014064445.2835813-6-zhaonanzhe@xiaomi.com>
MIME-Version: 1.0
X-Headers-End: 1xH1iU-0003nO-Ss
Subject: Re: [f2fs-dev] [PATCH v5 05/16] f2fs: support large folio writeback
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
Cc: Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Sashiko says:
> Does this mask checkpoint faults?  If a checkpoint error occurs (or via fault
> injection), the outplace write path fails to submit but is treated as success, so dirty
> data is silently dropped.  The VFS writeback loop omits the f2fs_cp_error() abort gate.

Changes:
@@ -4226,6 +4252,33 @@ static int f2fs_write_cache_folios(struct address_space *mapping,
 			err = -EBUSY;
 			goto retry_out;
 		}
+
+		/*
+		 * If cp_error is set, all subpages of this folio are not written
+		 * back unless the filesystem is mounted with errors=remount-ro.
+		 */
+		if (unlikely(f2fs_cp_error(sbi))) {
+			mapping_set_error(folio->mapping, -EIO);
+			if (F2FS_OPTION(sbi).errors == MOUNT_ERRORS_READONLY)
+				folio_redirty_for_writepage(wbc, folio);
+			else
+				f2fs_ffs_clear_subrange_dirty_and_test(folio, 0,
+								folio_size(folio));
+			goto retry_out;
+		}
+
+		/*
+		 * Writing back one large folio performs multiple block allocations, so
+		 * best-effort balance the filesystem before writing it back.
+		 */
+		if (!F2FS_I(inode)->wb_task && has_not_enough_free_secs(sbi, 0, 0)) {
+			folio_redirty_for_writepage(wbc, folio);
+			retry = true;
+			folio_unlock(folio);
+			f2fs_balance_fs(sbi, true);
+			folio_lock(folio);
+			goto retry;
+		}
 retry:
 		pos = folio_pos(folio);
 		end_pos = pos + folio_size(folio);

v4's large-folio writeback path lacked the `cp_error` gate present in `f2fs_write_single_data_page()`. 
v5 adds this gate to report `-EIO`, keeping dirty subranges under `errors=remount-ro` or 
dropping all of the folio's subpage dirty state otherwise ,keeping consistent to f2fs_write_single_data_page

v4 omitted `f2fs_balance_fs()` during multi-block large-folio writebacks. 
v5 adds a best-effort `f2fs_balance_fs()` before each folio, dropping the lock only when free sections are short 
just like `f2fs_balance_fs_folio_locked()` does. 

Sashiko says:
> Does this error handling catch all failure cases?  When f2fs_do_write_data_page()
> delegates to f2fs_outplace_write_data(), that function has a void return type and handles
> allocation failures internally without propagating an error code.

Changes:
@@ -3697,8 +3721,10 @@ static int f2fs_write_folio_dirty_range(struct folio *folio, int *submitted,
 		/*
 		 * The outplace write path failed to submit this block.
 		 */
-		if (!fio.submitted)
+		if (!fio.submitted) {
+			err = -EIO;
 			goto block_done;
+		}
 		if (submitted)
 			(*submitted)++;
 		submitted_blk = true;

v4 treated failed `f2fs_outplace_write_data()` submissions (`fio.submitted == 0`) as success 
and cleared dirty state. 
v5 converts this to `-EIO` during writeback to re-dirty the folio.


Sashiko: https://sashiko.dev/#/patchset/20261013115621.968742-1-nzzhao.sigma%40gmail.com

Thanks,
Nanzhe Zhao


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
