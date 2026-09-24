Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73ABFC98310
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 24 Sep 2026 07:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IHjQ2o7nAVsuLY8dn9ehW9lrAw/mjM1NhzClgHVF0bw=; b=EWiWvNf1oXExhGP37bIvkPw89m
	wPGJWqU7OoRb7pEYKYX+0Y7VApvmz9+C1jdLV/OmckaIcnhmoslBhktYdWchjCtYpxxUpRIuS9yLi
	1M+6nLBFfIALX073LweDdzzDxJHflD+71bdpVp+s7snlPy85lYLG+JiRE0iUB4kzOQlo=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x9dnq-0000ss-QH;
	Thu, 24 Sep 2026 07:23:32 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <zhanxusheng1024@gmail.com>) id 1x9dnn-0000sj-2s
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 24 Sep 2026 07:23:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=75FWx2B+/jj4qiq6OD4xfGZ+KktqHogQjCI/kBevvfw=; b=Euoaj7xwoSzPVwok1l9kPxwH8Z
 DiYOHVexIbuNzd5mpEHHyMVskry9A5/twYfjZrt4AHTuX3I3w6PgwRfGpz413BOmWvTeE/QFLU7et
 9MFfVabPJd7E+Dau31NNfEGqe51q0ateMuZlUXtUw6e0V5A1p/nB7d1G8uwZXscYIgto=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=75FWx2B+/jj4qiq6OD4xfGZ+KktqHogQjCI/kBevvfw=; b=RjvsLLRHnH2JixX1J8s6jA0MzI
 MGUHrl6QU48krFrmfDKbCFmAsqj56nlLktCiMBu6qB5TdsUdLg9wfYfnJ2NzyYuTV/Q3twWKzP0cm
 rsWpcs9hrKgPW0aX4N8d4rT3AE6kAi0gp1nadSu7ggUeRdb3DGeXNW88OkoSPDJvkg/0=;
Received: from mail-pj2-f19.google.com ([74.125.227.147])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x9dnj-0006Q9-9j for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 24 Sep 2026 07:23:28 +0000
Received: by mail-pj2-f19.google.com with SMTP id
 d9443c01a7336-2db18fe433fso8613055ad.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 24 Sep 2026 00:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790234601; x=1790839401; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=75FWx2B+/jj4qiq6OD4xfGZ+KktqHogQjCI/kBevvfw=;
 b=qUuypFLwG+JAX2w+VajzSr+lYYsTadu+DwThS/Varvl4U4cS/COohhNkjihrIUIXVL
 hdGa81ahBQqCeDFqTjrguxUGLKko/eatLiBYy72ypP8kmV996t1TxZIF4NxzYbv1+X+p
 MyLlnVXjkC/nrzKFjPHBTNKy+mUXcz5yyZU+XZq3cSLQSJpzY/jE2y/pS5hGAXXmXfWG
 DfI10KqS044gdHEKiuUl1IxPJ1KzIPmp45vkM1IyacuHsyZG04ArAopJX76ULAj72/Yt
 Q6Vj/A5a+kvy8MOUs+OJndXusDdZ2iQin3fhoBNGN/TmUfXYjfrND0kUNs3kRZ8anlUg
 IMLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790234601; x=1790839401;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=75FWx2B+/jj4qiq6OD4xfGZ+KktqHogQjCI/kBevvfw=;
 b=KwxuQBNbder2I5/J1Qkm5rTjnDwvn6MDqlz7/5kAgyLO7HFE4qJnMZB6cdY56oTWcG
 nETjpzAAkMqk8wL4+1LqfnXg2NGBO0WweF2CxFDNL1Q9/uskBZiCpeMj6wM+icnERbJY
 tqgV/WVd0CopUeDxsaeKZG/xdOEgy+SuNgK0+lLL/hpHWUH3BFt8x6vqKYa1jzj32qjF
 Mfji6XO+qrY+xXJVRCsjWodo+RTwKJyVCJWSA6yszpB6YlR6KHQKEJN7coG5d1ljK6+e
 hbMypq1yWhE7m/hvdsSORrn4HfU8l3ablRNpyek5K42JjcnrVyAsrpCNwZCNJD4k54y+
 h7pQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwNRtcFAmJU9JLAPKrFMYTUobAO9fR9vg1unx9cMTI6pwkwi2WPaWb3lY55ScPD3Aih6l6EP1UluZdDtq7odMy3@lists.sourceforge.net
X-Gm-Message-State: AFuF++l1SPTtG1oOwA2jjg2apgnY1jAw+sHQijYhqXTo8Da1N8yOtt+R
 F62y9itBEhcDVMTHgdamra1lTZ6W5kTvlWzSOFjUdD7jfZ0BOL0j+px/
X-Gm-Gg: AYBFou2kBcsrXJZb+ZjKM+bantN+er5o2YK6gOZTNM9l8qUOyYdIa6NrpPwdvEfkitP
 cay5Qo3X56UOhjgaRg7asnhSAzcRz8zxRTvIHn+3vm9ebDRVYvCHngr2/eHFlOH9XK00bSxL0Tu
 Kix60uv2w9zXtIqsz2pkWM6J8PWZJA5kL+QmzTnLx4h++Kb2Vp3WIg7CjosQxFpao9qo5UvmX3y
 xK92ymoUJ/jJCFAMFi/ixS7/43FhzzWmfOVd4emM6MAm/bbbNgwEXjbO5KmclNYIG8Q6pe3FwT+
 w2Tp2q+utGCTs003TpCZOAwexOEkegVdO/YyPHKfD8Z7tyXKvqcB2pFyfOJFWdDh/xaSc3sp7k3
 T57bnJWkjpMlIKsKXrBKaAwCY2//07LqYz4W9zfd4WUsrZEoqr8mtvI/3lM0o0W3Ch1QQO9mhyy
 HV4u+du5NAPKtmNJ8HcagqbPURjRoh7jCBeZUzRE0L6YFeEZAGn2zjDKnXaML1yfYCJoh009Vsu
 g0YpVxKrE7enAthmqfaug==
X-Received: by 2002:a17:90b:3888:b0:39e:d2a:e25a with SMTP id
 98e67ed59e1d1-3a098b98d91mr1482989a91.13.1790234601510; 
 Thu, 24 Sep 2026 00:23:21 -0700 (PDT)
Received: from osman.mioffice.cn ([43.224.245.178])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0972f111csm3219520a91.2.2026.09.24.00.23.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 00:23:21 -0700 (PDT)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
X-Google-Original-From: Zhan Xusheng <zhanxusheng@xiaomi.com>
To: Zhiguo Niu <zhiguo.niu@unisoc.com>
Date: Thu, 24 Sep 2026 15:23:13 +0800
Message-ID: <20260924072315.57755-1-zhanxusheng@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260924015213.1196491-1-zhiguo.niu@unisoc.com>
References: <20260924015213.1196491-1-zhiguo.niu@unisoc.com>
MIME-Version: 1.0
X-Headers-End: 1x9dnj-0006Q9-9j
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: simplify node footer check in
 f2fs_cache_write_end_io
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
Cc: Zhan Xusheng <zhanxusheng@xiaomi.com>, ke.wang@unisoc.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 jaegeuk@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Thu, Sep 24, 2026 at 09:52:12AM +0800, Zhiguo Niu wrote:
> -		f2fs_bug_on(sbi, entry->index != nid_of_node(sbi, entry));
> +		f2fs_bug_on(sbi, f2fs_sanity_check_node_footer(sbi,
> +			entry, entry->index, NODE_TYPE_REGULAR, true));

This also promotes every other footer inconsistency to an assertion.
Before, only a nid mismatch reached f2fs_bug_on(); the rest went through
the helper's own path, which sets SBI_NEED_FSCK, warns and calls
f2fs_handle_error().  After, any of them BUG() under CONFIG_F2FS_CHECK_FS.

The other two callers went the other way.  __write_node_cache():

	if (f2fs_sanity_check_node_footer(sbi, entry, entry->index,
					NODE_TYPE_REGULAR, false)) {
		fserror_report_metadata(sbi->sb, -EFSCORRUPTED, GFP_NOFS);
		f2fs_stop_checkpoint(sbi, false, STOP_CP_REASON_CORRUPTED_NID);
		goto redirty_out;
	}

and the read completion turns it into BLK_STS_IOERR.  Worth a line in the
changelog either way.

FAULT_INCONSISTENT_FOOTER is injected inside that helper, so with
CONFIG_F2FS_CHECK_FS=y injecting it now panics instead of exercising the
error path.  Deliberate?


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
