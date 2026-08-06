Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F9B6C55ABA
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  6 Aug 2026 03:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Rn1MdksR9wbV2atXAbX7qiC9Cs4ao5/Ju5vLjbDCl+Q=; b=JZSrdHo+jY53x7u8wFaA+iHY6e
	5BfFMimhfYU92VmHgjaEUdx/B8+xp0ZRrzFvmzLIa5InK5WnJIoJ/W6q6vt1WXYTVxiOGpZCVuSpb
	jUtyB88O5bGDe4Zoz193TAk1XPrK3WWIR76t++cNWgvy0KfGFx/o51qHq/GUFevry0Dc=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wrp3t-0000zf-GC;
	Thu, 06 Aug 2026 03:46:27 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wrp3s-0000zY-EY
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 06 Aug 2026 03:46:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tTwTLI+UIrcEevjMkJikN9bmk0Ls6I0nX2D9AGAaDik=; b=B39uURyDbxrREG4kroXdS3x0aL
 XV8BXi/c52ntyuqxlQdMFieL09NOpTap/oNV/DCnUtefYNVxxZl8VUkrKpC8nqbdB7jc7nFjWyiTy
 ytOgbfG3gKWcbYgo3ufScwhnJ3XbG7JK4H1JaDX3RlKkEspHCsDoC3jjfMofuQHLDw+Y=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=tTwTLI+UIrcEevjMkJikN9bmk0Ls6I0nX2D9AGAaDik=; b=EKt1Iz3UvsNDj7rTy9dxx5MxOn
 0UCI5ItjtufvnJyhTOfDZJ6e0+5lvwlMUcTPbsY7FeCf92r6XD6kqSa3DKmXIHIVJJO4SGKZSgZAT
 mD+YKmbQyFfMdYw7QYulMuKvOTVwgKmbY4FszmhqFqGUTOWeoyO6+oYTCTDVsyhbtCtE=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wrp3p-0007qt-CT for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 06 Aug 2026 03:46:25 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 07EFB42CBF;
 Thu,  6 Aug 2026 03:46:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6CDB1F000E9;
 Thu,  6 Aug 2026 03:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785987979;
 bh=tTwTLI+UIrcEevjMkJikN9bmk0Ls6I0nX2D9AGAaDik=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=jLSX2he8i5rDUE2t/O7FwJ5ZfSDgOyDorU9F8GmZe8VNqCDrNtME7/YcLZ7p1c304
 boJ27M0y0Ymqy8DcIZUFimjCPnsEq8GwZYFVHiAGNhxt0lWsNyiYwvNDKsoUGp2BM8
 ml7tX9mzbp2zXtgAbVmQluMgfA0pRcze0x2BGV+AbX49S8YWB+KQwhUcBWQJ1Bdejh
 a5M+3OuwoEqLHDVdvgPFh6p9y1TGxj2fsUEWm9KrCUtdZXWjUPsiqIIpMWtE7FnZIW
 5TpstDqesaon6txMxGvmhtkpNGjwkQJDHQ5BGCL6hP7wb2oKw85UWGri4tvm9YHueq
 n9wJA4i8OFeSw==
Message-ID: <7320b711-ab5c-4ffe-a6c6-86bfed6938c8@kernel.org>
Date: Thu, 6 Aug 2026 11:46:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: yonggil.song@samsung.com, "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
 "linux-f2fs-devel@lists.sourceforge.net"
 <linux-f2fs-devel@lists.sourceforge.net>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <CGME20260806030841epcms2p72fcdb3db8c3b6de434ceaff5635c8f41@epcms2p7>
 <20260806033918epcms2p7fa34d6df7c1045b19ac026d44b877f2f@epcms2p7>
Content-Language: en-US
In-Reply-To: <20260806033918epcms2p7fa34d6df7c1045b19ac026d44b877f2f@epcms2p7>
X-Headers-End: 1wrp3p-0007qt-CT
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: issue multi-device flushes in
 parallel
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
Cc: Dongjin Kim <dongjin_.kim@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 8/6/26 11:39, Yonggil Song wrote:
> On a multi-device setup, submit_flush_wait() walked the dirty devices
> in order and aborted the whole loop on the first device whose flush
> failed, leaving the remaining dirty devices un-flushed. Each device
> still needs its own data made durable, so a failure on one device must
> not skip the others. It also waited for one device's flush to complete
> before issuing the next, even though the devices have independent
> flush queues and could be flushed concurrently.
> 
> Flush every dirty device best-effort and in parallel instead: build
> one PREFLUSH bio per dirty device, submit them all, then wait for
> every completion, returning the first error seen (0 if all succeed).
> This bounds the flush window by the slowest device rather than the sum
> of all of them. No caller depends on the previous early-abort
> behaviour -- fsync only checks whether the return value is zero
> (fs/f2fs/file.c). The checkpoint path (f2fs_flush_device_cache) is
> unaffected; this only touches the fsync flush path.
> 
> The per-device bio/completion array is small and bounded (at most
> MAX_DEVICES entries), so allocate it with __GFP_NOFAIL rather than
> keeping a separate serial fallback path for allocation failure.
> 
> Signed-off-by: Yonggil Song <yonggil.song@samsung.com>
Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
