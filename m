Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B036CA9ECF
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 11 Oct 2026 16:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+h9NVF6dYkvNaouEpuuLWAPDcX/4RJn/7yuvvq6jCmg=; b=gzJy8b94YjqL2hroViSFi/rLLi
	mu1vESn5Owr4Ub2VjlnmtB4bPVNa55Bt7uZ8Pbfsntt1v8H12wSZCWgxGgKNRzf67DwJEagsv9j7U
	rSi4FZxiFqoFiHFr/UXfvM8STmCwlOxErNBDGm2CsCuTnNgkACydikjh5UcFVmwdHfsQ=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xFwj6-0000KX-B6;
	Sun, 11 Oct 2026 16:48:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <sashal@kernel.org>) id 1xFwj4-0000KQ-Tv
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 11 Oct 2026 16:48:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=P7uNgjLR1ue2A+THKCnp1XkskAQJ4zRbuEndOSWWT90=; b=K58j3QRmUHSJmhyJ+fw11jNrge
 dlWx/cbcSMTxBr9933nYJhqG2IicGrBJBXgQ4DAKSYxgTHN2UECkUvTk+W8Q0cc9lrF8XGcmRaBEz
 e0iilg4SwDsXfEdtIXOYXy73rPy8L9fTYSoN3BOLbpfmRrs1DE/RcnJJFGvPB4NTj/gc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=P7uNgjLR1ue2A+THKCnp1XkskAQJ4zRbuEndOSWWT90=; b=N6ZnQByDy0lxEVU8WhtMZY4wjU
 zy25L9JuiXkeiegdeHMiTmMUcLmimNBH1rQLPJorRQfqwEoGwiBIsfnUfM3A8c4L55BsOUD9iIUme
 u2rhGUvGfMgvS/Vx72IS+TnAx1MxFLH4e9KMN1Mk27VchZqsz4nGeaNg4z0GLPwx/t5o=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xFwj4-0006f8-IT for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 11 Oct 2026 16:48:42 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C27BF43AC4;
 Sun, 11 Oct 2026 16:48:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2AFC1F0089E;
 Sun, 11 Oct 2026 16:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791737316;
 bh=P7uNgjLR1ue2A+THKCnp1XkskAQJ4zRbuEndOSWWT90=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=PoV53xnQllFG0C9C1Jl4xSjUw/61Y7xGtmyOW+RKm9Pv+NlN5UQv5cCOd1o4vF3I8
 4WMWuigw83ag+/DEtTO0flVB9nLh8Es2nt223+IN/95yfBpe0/pbVbL0Unjnwnnzj5
 jXimlSG53CDPOzXynHGiFrBlJZz4ADDyNUCsMhfiLFxqGlUH/9LcYdCHz5uBLSgJhC
 m1CxXYdQA/VsAhUaaovW7xLs2eGKOSPYOEYsMDQ9bJ52ZzpEhqM87oqjk79AS5wSDu
 DtE/w2fq+XoXvYKcUsRQFscWXmKEnItBnwgaxzZow9jtZmZhAO42SKPo3YFW86LIXS
 r4B+mCB8o0RnA==
To: stable@vger.kernel.org
Date: Sun, 11 Oct 2026 12:48:13 -0400
Message-ID: <2026-10-11-1-daily-reply-0006-f2fs-pinfile-6-12@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261009112220.2276173-1-chao@kernel.org>
References: <20261009112220.2276173-1-chao@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1xFwj4-0006f8-IT
Subject: Re: [f2fs-dev] [PATCH RESEND 6.12.y 1/3] f2fs: fix to reclaim space
 in f2fs_allocate_pinning_section()
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
From: Sasha Levin via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Sasha Levin <sashal@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>, Daeho Jeong <daehojeong@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org, stable@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

> It needs to trigger checkpoint to free space reclaimed by f2fs_gc_range(),
> otherwise, fallocate() on pinfile will fail easily even there is slash
> space in conventional zone.

Queued the series for 6.12, thanks. Patches 2/3 and 3/3 are queued for
6.18 as well.

-- 
Thanks,
Sasha


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
