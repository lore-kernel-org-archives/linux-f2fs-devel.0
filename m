Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E0B9FF886F
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  1 May 2026 00:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4RhZogF0oVzCW3PfYXDcVGYDYxBKl6+r9sD7AhKgL0E=; b=T5A+k/mIDu49Rzuij5AR2veTqW
	e+1ket3GZtMCS7oRy+VcccaKsO7kPLEpwm5DxKmwA4agWbdWyykU8kQJ9GcEA3YTX87j4Cz0xm16u
	VQ/7udnPBdmjgwLBWvlMuXK/sLLrGE/jA5Tfk7mEJvo83LGKtmy93tv0n2d+am6WEsWw=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wIc8S-0002SR-Ca;
	Fri, 01 May 2026 00:53:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <sashal@kernel.org>) id 1wIc8Q-0002SL-Vl
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 01 May 2026 00:53:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nQF8Ykfj8+2QCwIYCJZ21I3zd5B77lm7Ueq+m26Y97M=; b=MeGopl0KJ1bzlz2HF6a0ytlV6u
 KH4WeOp9hpz8smY5Dm7QuPebCHC67ySi+PPF3RBGen/a8vLzS+kU1rpMMgwFtVjW5C8Ew3n0jm4Kp
 /9shL97w2KLhyBVyUr+uzWs/VdkMjh9S2WAW5zYT2LN4msFSqVS1cRKa6HSWNr9iy56A=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=nQF8Ykfj8+2QCwIYCJZ21I3zd5B77lm7Ueq+m26Y97M=; b=AXcKXuoyBw2dAlfr5QAPaBDlZI
 XnmFka0BiBGWUbPR09evqaVvG1ImeoimHImKccJlljKiQ0tHg2BLLLBoXMb8tYIsyNd34BUg4ofNN
 pKz5LRHyScyUo4xiykt/n6nep3gOxG1eYbgFtYtCy4mVlLQTX4Qcczh31MIq3W2f+Y1M=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wIc8N-0003jS-5C for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 01 May 2026 00:53:36 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id D05AA444C8;
 Fri,  1 May 2026 00:53:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06A66C2BCB3;
 Fri,  1 May 2026 00:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777596804;
 bh=nQF8Ykfj8+2QCwIYCJZ21I3zd5B77lm7Ueq+m26Y97M=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=G+fLdPSoHn1ju+dGJ+phcc2I05mJOy2mbsT4Lq1ZmEwhMnDvop0Q6dim8/MZueIwY
 OpTJBqfazrdzbbZk6WbYyv+EWo+2aJfmDNUSMXENPFwod2TQXlps6crJKWNEzA6OPJ
 TcXY9Vs5uzTenlGnjho5P5q3YDzsnDKS9W8JaFY9fMN3f7Etmbw6jTFJ60aRdwlub2
 4XnTJaA6Cyw123aB6YsWdRttdJYiU5x/VcAKywu7ZLszFWqyqnWRz4tyeORjQt8a2e
 NMFCR6N8/+MlxQ0GFUQy11b3tZsOww/jM2YGkT/P5PwDEOvfHHWbqzXRXyJi7kybE8
 ifeott33tBAZg==
To: stable@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Date: Thu, 30 Apr 2026 20:53:22 -0400
Message-ID: <20260430160000.item006-6.1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260430055537.2105721-1-rob_garcia@163.com>
References: <20260430055537.2105721-1-rob_garcia@163.com>
MIME-Version: 1.0
X-Headers-End: 1wIc8N-0003jS-5C
Subject: Re: [f2fs-dev] [PATCH 6.1.y] f2fs: fix to detect potential
 corrupted nid in free_nid_list
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
Cc: Robert Garcia <rob_garcia@163.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Thu, Apr 30, 2026 at 01:55:37PM +0800, Robert Garcia wrote:
> From: Chao Yu <chao@kernel.org>
>
> [ Upstream commit 8fc6056dcf79937c46c97fa4996cda65956437a9 ]
>
> As reported, on-disk footer.ino and footer.nid is the same and
> out-of-range, let's add sanity check on f2fs_alloc_nid() to detect
> any potential corruption in free_nid_list.

Thanks, queued for 6.1.y.

--
Thanks,
Sasha


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
