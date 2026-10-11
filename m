Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2358BCA9EC9
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 11 Oct 2026 12:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7uMHkdnTJQBj6+A2D+VKVvx9WY/K/USVM4RHZkHd8zg=; b=N3yyIKy/FQ2FwVxixbCOyCIGxd
	CSLsTFUhWdcYR+aVSMlb/+KuL8QzuDGFbbvGaZ7MDf14vx2LIimVbMFZmDp+xUBcUjTFsJ5081E4x
	NR+R4IMTmu1CQzAGMubNrZdXalRcpOv00PTb+bqTC62PZ9+VJjvgPEQki2IQ537ujKLA=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xFscZ-00078Y-P8;
	Sun, 11 Oct 2026 12:25:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1xFscZ-00078O-0O
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 11 Oct 2026 12:25:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=irOGxmKVDrEZKvZjgOaKPJglMLW7T/ynGH3oeMhA5Dc=; b=TDTK9syV6rDLQgXcT9MOfAfqru
 D24B0mUOGAzKkghvhMmUg/t+nDK5vk9LOQCPUxpQ7IxHZwtCk3AHAJAaLfR/Zs7e2FO6IARgOyuS4
 owAxnqe42GkT5g+eihp9DVaJs8WxgiLFKufJGytoFhsgCTDCJNgrIYAj5thItCnsujmY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=irOGxmKVDrEZKvZjgOaKPJglMLW7T/ynGH3oeMhA5Dc=; b=QpNgWh7WyQjR7pEillszkt8TZY
 9RcGPe7jdr5vNZg5OLmfGrymfzwdwS2Ic1QcqMQr23LwXzQRoJEbt2GoB6t+piVzguQYf0TeLY+IY
 peDDy5aY/4WYmdBpPtVTm1hOZ2lo2TBl0QM1mVClUEe+ALcGpVde7EkFU18vCdNtFA0U=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xFscZ-0003Ep-AS for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 11 Oct 2026 12:25:43 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9936D600E2;
 Sun, 11 Oct 2026 12:25:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49D241F0089B;
 Sun, 11 Oct 2026 12:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791721536;
 bh=irOGxmKVDrEZKvZjgOaKPJglMLW7T/ynGH3oeMhA5Dc=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=HRVlA/MuFOOBYYxt+yvZc7WrB9DTZooIq0n+/qthPKkL1OrO5egtQcqKfRd8EHCeJ
 VT0J6rNLR8zvWXZnC4mbqiYIQbja9qeC0x6MPJ/IlwFXGgfrzSXSGlkDi0UgYfjwkF
 mvh39De4NklF0SJCfBA8b1h6HdMDrQzbQL4w1IMAxXrSa0MzJTlrIrzioFa4x+8FpO
 6WaIsZq4MVabg8dD64/6OZXfnnzPhEo5jiqzPnpH7sqhxJXNHWzE+wMjlD5mt2ff5h
 bq0BkvsaUfgq8E+oIbPwLVTqEFWhKqaiJoKxq8TCNhM/t60X3DgB/jznU9rV/jbY2P
 Feh7NV0CDbVaA==
Message-ID: <8cbb8aee-189f-4c69-927c-7deb1a50ab8f@kernel.org>
Date: Sun, 11 Oct 2026 20:25:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Kaixuan Li <kaixuanli0131@gmail.com>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20260919130925.1899994-1-kaixuanli0131@gmail.com>
Content-Language: en-US
In-Reply-To: <20260919130925.1899994-1-kaixuanli0131@gmail.com>
X-Headers-End: 1xFscZ-0003Ep-AS
Subject: Re: [f2fs-dev] [PATCH] f2fs: bound the SIT/NAT bitmaps by the
 checkpoint pack
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 9/19/26 21:09, Kaixuan Li wrote:
> sit_ver_bitmap_bytesize and nat_ver_bitmap_bytesize are used as memcpy
> lengths into and out of sbi->ckpt, which is sized from cp_payload alone,
> and nothing compares either length against that allocation.
> 
> sanity_check_ckpt() has checked these two fields since c77ec61ca0a4, which
> added them after a crafted image overran build_sit_info(). That check ties
> each length to a segment count; it never compares either against the
> allocation, which is the half this adds.
> 
> Mounting over-reads in build_sit_info() and build_node_manager(), and the
> first checkpoint writes the same lengths back through the same pointers,
> so the over-read's contents reach the on-disk checkpoint. An unmount is
> enough; the filesystem does not have to be used.
> 
> Bound both ends the way __bitmap_ptr() lays them out. The three branches
> differ, so a single sum of the two lengths would still admit a small
> overflow when cp_payload is non-zero.
> 

Cc: stable@kernel.org

> Fixes: c77ec61ca0a4 ("f2fs: fix to do sanity check with {sit,nat}_ver_bitmap_bytesize")

The overflow issue exists before this commit?

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
