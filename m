Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9484DCA9ED0
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 12 Oct 2026 09:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xFPg1uCfacAvE78FwD/Ijno6W6zzBx30mlZxDXV/454=; b=fPVzETEp5JxLpfKVyJtPcOhjxm
	EoE7YFiUcvBklyXZspQHQENWNOS4x1kYGNl4wk/DCeRJUxvqMZGzFHYoNRTLQuTkfZmIi9VxX8tbQ
	suuG7HPb/4kjsWcKXVfhIeddDOhzwDe340QsXosErfuMExTEHK5KOtIgZFNy97J+qP50=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xGCWF-00029d-Ri;
	Mon, 12 Oct 2026 09:40:32 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1xGCWF-00029X-BB
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 12 Oct 2026 09:40:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=eWJXzQj4CB0I4w0+fSpYQ/eiQ5nudYEykgBM7gqYad0=; b=SG+YpRmtNpsmSS9+3w20ZIDg7C
 Ox0kAyObfsnP6NHr8icTSJYJ5hgvTgfgTqgfV6EaffX27ZWrcg9YOH/8qU9xrFoydRN35WT1FO0UH
 ec5KgRWK1mjmYf52j0NOLGkpESGW9vphvR8Pj3fafixW+EGz0412fjsckfi0giWXvV+A=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=eWJXzQj4CB0I4w0+fSpYQ/eiQ5nudYEykgBM7gqYad0=; b=Y3mfG/4E4uGfVfZHBRpOarz0dx
 mLyTszVHBxm2GXG2lRr6hUCTcWf+o5NZFnrijWIBM668U1iuRmcQ+T9DPdFv61IKTFPpudVoZewTn
 Nh6zFeM7S86Y3b8mweJYPaMjpv14Ls9ZN9161x5adbE30hJ+6tc9olxuPCIT8Sxca8xE=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xGCWD-00060a-Cn for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 12 Oct 2026 09:40:32 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C1126600E2;
 Mon, 12 Oct 2026 09:40:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07C691F0089B;
 Mon, 12 Oct 2026 09:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791798023;
 bh=eWJXzQj4CB0I4w0+fSpYQ/eiQ5nudYEykgBM7gqYad0=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=Cnhk2vu83gD/oGcvKEitNIYxcgIwttjyL6MfbvUc/91Ur89RrSJYULKqfdSQUsI2q
 YgGBPuFMt90PhKvGEXW5bvcYLQFe/AQ6h736ceNP5Fd0DZG6n7y9tbNsqvYhOY91eG
 +JxmMDPisB7c+DPUnJ3NmArUiQF1WTaRmC5u2EgFIkmAoxBgaEmvvZ95od4Ub3Q5ey
 y/dZrVVSW6ysPN1RVTAS0ryVa9fAD5oaYjg07oQt5T95LnrWYKUhXca9ycmOXcgZ1l
 QjMf2EK4/p1ImovCl7Kn0PhT2suITKddNQqzvxhmP5r4dwBYoW6zHpTVbwy9tzXgYy
 iRF4mGHE0PE4A==
Message-ID: <8ad8c5d0-573d-41bc-9309-b2ffccc66b32@kernel.org>
Date: Mon, 12 Oct 2026 17:40:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Joanne Chang <joannechien@google.com>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20261009095335.749891-1-joannechien@google.com>
Content-Language: en-US
In-Reply-To: <20261009095335.749891-1-joannechien@google.com>
X-Headers-End: 1xGCWD-00060a-Cn
Subject: Re: [f2fs-dev] [PATCH v1] f2fs: allow pinning empty compressed files
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
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 10/9/26 17:53, Joanne Chang wrote:
> Commit a64a3fec11e7 ("f2fs: force out-place update for all writes on
> compressed file") updated f2fs_should_update_outplace() to always
> return true for compressed files. However, this function is also
> called during f2fs_ioc_set_pin_file() validation, so pinning an
> empty file with compression enabled now fails with -EINVAL before the
> compression flag can be stripped.
> 
> Fix this by guarding the f2fs_compressed_file(inode) check with fio in
> f2fs_should_update_outplace(). This preserves forced OPU for actual
> compressed writes (fio != NULL), while allowing f2fs_ioc_set_pin_file()
> (fio == NULL) to proceed to f2fs_disable_compressed_file(inode).
> 

Cc: stable@kernel.org

> Fixes: a64a3fec11e7 ("f2fs: force out-place update for all writes on compressed file")
> Assisted-by: LLM
> Signed-off-by: Joanne Chang <joannechien@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
