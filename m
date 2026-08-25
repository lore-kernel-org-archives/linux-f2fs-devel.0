Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C83D0C5DF94
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 25 Aug 2026 05:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xlclL2izufORWvtSI2xvDxWZeuXNHW2Zdp0TkPCTYn8=; b=UoCAb6TJIseaEkpCiH6gUNlcVg
	3FCPbs898ZMcHDMi+/jHUMNS3XISCTS2UlzBKJhVizJhrNk9S1IZFBpAZbbexrjlY/eIb2q7KhpKx
	579ifDhkO5Md+ZMuLA7I0OXL4rFGw/HG+qSVhagdDhTNpq2YmblfH8R49Ek/QpkR6a5o=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wyjw8-0001tY-Ul;
	Tue, 25 Aug 2026 05:43:02 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qwjhust@gmail.com>) id 1wyjw7-0001tA-Du
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 05:43:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:MIME-Version
 :References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qTlikeeUVw0SD7zrbt84DUPPHGWl7mj0K8155OEkssg=; b=EtyBbn93z6MWqhR6eLQNTKlIVz
 ipqpytSr96TnXFOvFpi2nLDoLPa1aOcLhYtyUos5kAmVbrBfqcI3+X5dbcTt5xu/JFk8UH+hNEK5A
 CVmqwMNlg+vM6Rmq/bKe3akxxzv2UNFqw+Eg005JKJeybiBu8S3itRJyUigRa+Ae5KkM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=qTlikeeUVw0SD7zrbt84DUPPHGWl7mj0K8155OEkssg=; b=ZUR2X45zI1TCz3k5jb02S8aT02
 abDCt7IgAjCilKjBaTsDLOYCF1Ut+uki3taBlZuY3oW+LQZGXXjfinn9YStWkI2HmvUt9XS1tyV3e
 8oxluXLCq5xyiYn/Mug/hFuUzE3EMjdJ4QqqS5WRMet454Z+k7/uLMlqxgMFht7Ld9LQ=;
Received: from mail-pf1-f178.google.com ([209.85.210.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wyjw4-000357-K0 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 05:43:00 +0000
Received: by mail-pf1-f178.google.com with SMTP id
 d2e1a72fcca58-84eb992a881so3295431b3a.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 24 Aug 2026 22:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787636575; x=1788241375; darn=lists.sourceforge.net;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=qTlikeeUVw0SD7zrbt84DUPPHGWl7mj0K8155OEkssg=;
 b=lKujSPLnBdpmQQ6W397SL3cYxfnqmt4IbwBy+tk5ZFEjHpkmpLVYtEoRPnzrug5Mbb
 GjR/q8hoA86PXpY56cYleb9WJ/Zm9Tqa5rSiGgV2jO9bJb/Nfz70zIz+0Pmuy2lStqYk
 Vi8TMUgL2Q3Tl427Re9yvTU701S6ATwo6Ut50zxU2eNpfudhZuBk61h9w1Z9/8CBMw5E
 upjBhNNsRwzaed4zqfj4fbaua5wFt5lUbBkLqlratjSDZZ9kH9bqCBtK6aULO+F1rr+B
 /V3B9DRtmFSAowIQxMx5121GjcVRVCyLV0o2aJepbkUBKmPQSxTDn8aQJFHw1q6cs7LW
 c9qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787636575; x=1788241375;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qTlikeeUVw0SD7zrbt84DUPPHGWl7mj0K8155OEkssg=;
 b=EMsGjuAWbww2a9TQw1njX5ssp2oWH/QlyWILQnUF2P1ZtU0l8PlxkAAYQBT2TCwFic
 744os+LauO+uo50oPmNG/T7CEOo1BdTOslr/YSO/Sh3XmwXmdjWUWnFitd7OMmxyGXVR
 nzH8XXZ6jt8cLULV0qLe/6rWLMyZHOO9V3K6xNU6ZpD3oBXCEB08ZNfU7uchnLXiy5sz
 MOKEDQpS+NNK6M8MclnzVgXbI9Ytrz/VBzJPifrmD0ycRKhkEIcyYwpeBHKr0+Q58f4/
 F5UN0JUtND2sXmESLHLhkJNG+FoFaG4OelL6LiVo3OH8s1FKXryRX2QMkV2qj7jubgvp
 yaPQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpI3MowRskMV+jOF0sCCsyrggTcOadPJEhXLIIc4SUiamtMGdBOrje7aOfp9IHn6jlMs9VYRF8XAsMyXVdFxXzq@lists.sourceforge.net
X-Gm-Message-State: AFuF++na2poc5YiQSnCjDheBUniOlWdv94YSReoqiRcbqq0oROjFpxiz
 VxGMZ3rAPj0WREp8A8A6UPQIWEPKzzkSRpW/wl9vl9pTFskldaY3S9+sxU83DfJk
X-Gm-Gg: AR+sD10IQtstd06WIqzmvpJLWX//sJqwrA/WiUXVPpSycjpjTZiW8WZj4GrmPASP2KF
 QzhPqD3R86liS9OQ/myReOV9kIq7e9CKPzuAcgaghvoB7jdSkY+Ims0OiA25kss+9y3Cid5tq32
 HD5R/fE7Nk42MS/vIOApsW8NTF1TbHbYsYp1juEC9iXpm/UpKlYLgXUCLk+aiYkG2Qq2DE+z87f
 KULx485+hDYYzclBVJLASX2UOvD/OJJWJhLtu1VL09o/yV5f2BXTQCzml5vtXW3Hf/ciBCHKM6H
 vpLfweFiibFJC3efq9dqmsdqt7s2VM5naXCYpQlgBXDex8Ctc0dqnKcqDIGV+PsSNKsojyLrX8Q
 mxmziE3ay+LjKYwwwXQ2yJ8opENu+hI2Bck8oZ8s1Msgpx1duqUcLiApMkuHdGw8idWX/IYEp92
 /gZsADlggVxUEIkwemim96KymIWMAYMSLID8XJvfV0T9gQfuyBBVCrPKPDXbuYX9F00WyRcoZ1J
 L1zHLJpca6i8kXur+jAQCeG
X-Received: by 2002:a05:6a00:3c92:b0:848:30c3:45dd with SMTP id
 d2e1a72fcca58-8523c92e3demr6987519b3a.11.1787636574890; 
 Mon, 24 Aug 2026 22:42:54 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8520f14a01asm2611416b3a.43.2026.08.24.22.42.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 22:42:54 -0700 (PDT)
From: Wenjie Qi <qwjhust@gmail.com>
X-Google-Original-From: Wenjie Qi <qiwenjie@xiaomi.com>
To: Chao Yu <chao@kernel.org>
Date: Tue, 25 Aug 2026 13:42:48 +0800
Message-ID: <20260825054248.399693-1-qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260824134731.3704352-6-chao@kernel.org>
References: <20260824134731.3704352-1-chao@kernel.org>
 <20260824134731.3704352-6-chao@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wyjw4-000357-K0
Subject: Re: [f2fs-dev] [PATCH v2 05/12] f2fs: cache: use meta cache
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
Cc: qwjhust@gmail.com, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net, qiwenjie@xiaomi.com,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi Chao,

> case META:
> 	nr_to_write = BIO_MAX_VECS;
> 	break;

and in `f2fs_sync_meta_caches()`:

> nwritten += sbi->blocksize;
> prev = entry->index;
> if (unlikely(nwritten >= nr_to_write))
> 	break;

`adjust_flush_cache_number()` returns `BIO_MAX_VECS` for META, while
`nwritten` advances by `sbi->blocksize` for each entry before the comparison.

Are `nr_to_write` and `nwritten` intended to be entry counts or byte counts in
this path?


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
