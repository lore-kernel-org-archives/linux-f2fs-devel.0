Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BE43C5CFCF
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 14 Aug 2026 16:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=JfbgtnkWHgdAvHe/BRkANs7J04HaqCGDjTv/dHRdZuY=; b=KbpWbUhsxHthTV4imsGZPHVP5v
	1GnDNjY2P+XXeQKojPDWiMcx1Mctg6xI6pdXMSULqMg1lPdxmv7Bn40yMv+P46mO/EU9W7HX9g9+E
	lcDIky0tecdkrobQzSUjrvVHZns1OjOHMiHcEhh84BNFhXebYnGX9q/h+KsIbfzo8hU0=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wuv6O-0002bz-5S;
	Fri, 14 Aug 2026 16:49:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <yangyongpeng.storage@gmail.com>) id 1wuv6N-0002bt-Ck
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 16:49:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WBOhL6yD2Fr5WJGSmgtiEzRaohcDni1jbLWWy09rRXc=; b=lka0ukTsL7N0ZGOkKXWJrT9PER
 aYe9N+sbCbqRL3iwi/FFplwsYcIQpZnL6NVn6zYU59eWjHugL4DpgoZPwSCp39CBQKNr8cy+b/TKV
 np4gxzGoCsEYl9txWNurD94vBz1BapSKn7mqycxRaXYrHbf7MecixWU5iyP2OpbQc1P8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=WBOhL6yD2Fr5WJGSmgtiEzRaohcDni1jbLWWy09rRXc=; b=n
 Qhq3wRpDhRL0vTMSYrqi46W9LuwuIuB8oWZsQIpj1ziQBsTgW1H9UcTj/C7ituz2Q+O2Q5TKEymIL
 FhAaDOldUn0eIzyGUraBgcTqzXBI9/n4AkgNxys+59db+2Xb8XxkiNc5cRePzO20swGKs/0qwQL3s
 3Poci4BkViVZck38=;
Received: from mail-wr1-f53.google.com ([209.85.221.53])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wuv6M-0008JJ-Rn for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 16:49:48 +0000
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-481412f1828so460252f8f.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 14 Aug 2026 09:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786726181; x=1787330981; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=WBOhL6yD2Fr5WJGSmgtiEzRaohcDni1jbLWWy09rRXc=;
 b=YPnWBWoy42hVE8LXG8DBDGzhH0iT3bopWDDqtEpZlSVDFTt5lNPSEoodCxkyhLnso/
 V8Ux3k3Jy4gb+tl7qeseORJuOEAanERPnAP6gmzl8+d/x9PZ4aiDD5LagQeEGuLLTkih
 t8NUxLFlLZlSAZjJQsfdFxYEhmezM6ZFoJfk7kT0DyCAQHchPOYcbLm+Fy9dbahnyI1V
 qKu6xJLe7g5mP20R8tLIoEwA9Wml+taMkuH7A2AKeTMb4V2ds4THcZyqisNRLtnieqvo
 y/ICzpKlIsq5BC6J+XlWjTZNt8Y1O7469kMe9xKw8rssRM27hHShcByxNKUM4+byKN9w
 nKHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786726181; x=1787330981;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WBOhL6yD2Fr5WJGSmgtiEzRaohcDni1jbLWWy09rRXc=;
 b=NAT+ry8SAGp9B3+EIXf25i296OakVCl0TMWlJU9Kk/fFGEdCeOGLVFVZUAeoz8ZHgP
 V2jrZHDItU9Y4FROFIOiPzKgGHSDJUKfvFm0HrceePUlYezkkzy/BGw7JRAAC0t2wj4q
 0CCFMrxzZcNC1SqyLQLcpUjEUY6tvR1d3D7rEBLreIjBeDIzj7LFTgnj+p8q9+kMERaF
 v06PCPbfBj0kNG+jY8IS9FiHqq/ncfdl53BYZ73JYtDDaGH+jLsi7dfO0INwGNSeXuEt
 dilbzd76pZecXc5qhZWUUGe/ihXM5UwTv4YCQ0QrVppBNt2bTg2wFPTlaOV0vqmWsM6w
 DUXA==
X-Gm-Message-State: AOJu0Yw5U/KuBMwZTR/SvCQkJ2g7le3HBN7WPH/rPw0QqUU3gN9Qcxg8
 ZQYZz3ye/3IZ3vLIzUaGgj/RGVGrYKLPGLvjtPfe70VP9Yb8KkfGKkqW
X-Gm-Gg: AR+sD12qedNC3j578HiSKWCwJBBZl/hMSUxVbblqCQo1hA9JvAaKz9dxUwNuGAc8Vvz
 /090zgxuMuVyGztgY6y3/FmKn0HyZUDwDXLcf5R5A59XlXBF+v3txNFOgpQtMCRKbutsig4rcQY
 kfMobmqp7A76TAGEq9vvYylxBOKxUTzn545r9Hu8D4MmMA6D3DWyfnJTYVf/ndD2dn3rsiD/ZGq
 LJsZrObYHJPxESY9spsyKucYCJCKIBEN/+lcvGXuf38Jg3W+FbC31HUCkQOzoxQ9z9XcFr+vnPy
 CcPWgsBwZTxaj8gedSiye++5kPjjR0QkFao5fX9awqloc05cTi4lY+xBCkh/qQa4ElIYAsNxfwt
 BiSZSX/VM6mMwAFevnt/UNH1zkq70riduic/d4saCKQaE/AYRr8dnNswGlok6csIXnZpYHpxXUB
 FC1yROk1W2UPIgs3/LttuhYunY00wq0P1TKFsMwPDi3QgIPEpo9pRxmk6vObhYVGYdjZVcuprOI
 aVVWzm8lOwm0kHyBw7r3AOgtayY9L1qncWAIXoL+5/eng==
X-Received: by 2002:adf:f708:0:b0:47f:aead:f81b with SMTP id
 ffacd0b85a97d-48160756569mr8593520f8f.21.1786726180520; 
 Fri, 14 Aug 2026 09:49:40 -0700 (PDT)
Received: from xiaomi-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4815f2b1a91sm9021223f8f.21.2026.08.14.09.49.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 09:49:39 -0700 (PDT)
From: Yongpeng Yang <yangyongpeng.storage@gmail.com>
To: Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>
Date: Sat, 15 Aug 2026 00:49:25 +0800
Message-ID: <20260814164929.693412-1-yangyongpeng.storage@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Headers-End: 1wuv6M-0008JJ-Rn
Subject: [f2fs-dev] [PATCH v2 0/3] f2fs: fix read extent cache merge and add
 debug interface
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
Cc: Yongpeng Yang <yangyongpeng@xiaomi.com>,
 Yongpeng Yang <monty_pavel@sina.com>, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Yongpeng Yang <yangyongpeng@xiaomi.com>

This series fixes a read extent cache merge bug and adds a sysfs-based
debug interface for inspecting the in-memory extent tree, which is
otherwise invisible to userspace (fsck can only see the on-disk i_ext,
never the in-memory rbtree).

Changes since v1 (RESEND [1]):

- Patch 1 (was 1/5) reuse the result of __is_back_mergeable().

- Dropped [PATCH RESEND 2/5] "only initialize largest extent without
  extent_node at inode init": no benefit was observed in practice.

- Patch 2 (was 3/5) unchanged.

- Dropped [PATCH RESEND 4/5] "add extent_access_mode to track extent
  cache access patterns": on phones the read extent node memory budget
  is small, and no hit-ratio improvement was observed in performance
  tests.

- Patch 3 (was 5/5) -- replace the ioctl with a write-only per-sb sysfs
  entry `extent_cache_debug`. Writing a file descriptor to it resolves
  the inode in the writer's context, dumps the largest extent and every
  rbtree node (fofs/blk/len) to the kernel log via f2fs_info(); inspect
  with "dmesg | grep ino=<ino>". A matching f2fs_io `extent_cache`
  subcommand is added in f2fs-tools.

[1] https://lore.kernel.org/all/20260612115839.2065903-1-yangyongpeng.storage@gmail.com/

Patch 1: fix extent merge failure when largest extent is not in rb-tree.
  When the largest extent exists only as a hint with no rbtree node
  (e.g. after shrink eviction), a newly inserted extent that is
  mergeable with it is not merged, leaving a gap that fiemap reports as
  separate extents.  Merge the new extent with the largest before the
  normal lookup.

Patch 2: punch largest extent instead of dropping it entirely on
  overlap.  Keep the larger remaining left/right portion after a
  partial overlap instead of discarding the whole largest extent,
  preserving cache coverage for truncate/overwrite.

Patch 3: dump read extent cache via sysfs for debugging.

Yongpeng Yang (3):
  f2fs: fix extent merge failure when largest extent is not in rb-tree
  f2fs: punch largest extent instead of dropping it entirely on overlap
  f2fs: dump read extent cache via sysfs for debugging

 fs/f2fs/extent_cache.c | 100 ++++++++++++++++++++++++++++++++++++++---
 fs/f2fs/f2fs.h         |   1 +
 fs/f2fs/sysfs.c        |  18 +++++++
 3 files changed, 112 insertions(+), 7 deletions(-)

--
2.43.0


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
