Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4AEBC5516F
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  3 Aug 2026 04:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fkTpkSTcYXSAs6R7L6a6qifLRBMw2Y5ORhNjFg8QUCw=; b=O5DXz22D4eUduKb7109KvvVsBj
	rev5FjDOa9dJsey4/gRcFeELwmhrGS4FrmPfH0K5Gp3XN0MA4T8nVis7S4S53odjEQK+SWS81a0je
	vOsGdcNG9SeESP5MQJoHY68qGk5jZjo0NnvV9RPS9amSzAwbNKx5YOMwWraJKjpn7rKg=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wqkOc-0002bU-PT;
	Mon, 03 Aug 2026 04:35:24 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wqkOK-0002bA-EZ
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 03 Aug 2026 04:35:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/qS9W5xhyCc+Co2tLQQ3k9Uyf65iDb5OPiUZJ74vDx8=; b=ZrmynTyHfD6obTjDDVSs3cCA3N
 +wMHXRAa3cFD+YBbYXAnn6Z4tEW5e3hweKHFcnEEwsrpRFWcVD4+jql/mY6sfXR3n63t7eDzW137/
 GRfLnDVSHN9eLwxnAtkRt6wglV8A1lR6hWz8OSHv9+/ACnRVM4D7mrFma5TCVdWotpEA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=/qS9W5xhyCc+Co2tLQQ3k9Uyf65iDb5OPiUZJ74vDx8=; b=RPnkjNxoRj09wFGjS1IHVE2e1h
 B4tAENiu6RWu+aPJptxQxGk3vJ5eDpt8cgWmE3w4uksfaM7/TSEYg92X4ht6cNJhLk+QECkULhL3H
 GwsO3Of9Fhg+5gcrNdk2NkajdsFfBgw4F2A/KK3jcieB7maTsx5BeUgnOVuAmdZe+GXU=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wqkOK-0001Gg-W3 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 03 Aug 2026 04:35:05 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D64C941AB3;
 Mon,  3 Aug 2026 04:34:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FCE61F000E9;
 Mon,  3 Aug 2026 04:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785731699;
 bh=/qS9W5xhyCc+Co2tLQQ3k9Uyf65iDb5OPiUZJ74vDx8=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=O6QKEoPtVlGk8PSDDD7uvaUxJH/Xqb3Ht7cK8U8swtvCE/h+0yZiR4FmY5DFc5Q4F
 hzp9Vfmv0Prc1hzsLb6e8g39KhZKVbcRNDQKIzJHmmxeQ+rXx+V3Q93S7IURi1MtDW
 r9hOctbrkJpqfVhWztd24hlY0sarFQxzNIQXN3yvnQWuAT5W9/72kYKJ/4pfUtaCTK
 +yIbmhCRfHmgYX3QjjL0m4S2qMT62ZQkXNKNlHeyXBZRDIWgHqJBE2DDz0lmq5t3Qp
 UthyKmgAcfIGydj605eS8w+8f18vJTnnEo8RDD1fPYdW5My44WpcfZ1ahueJgIUgB0
 5wpByx8K8q1ew==
Message-ID: <90e314e4-00f2-4f4e-a054-91936538f5de@kernel.org>
Date: Mon, 3 Aug 2026 12:34:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Yangyang Zang <zangyangyang66@gmail.com>, jaegeuk@kernel.org
References: <20260701092850.1247010-1-zangyangyang1@xiaomi.com>
Content-Language: en-US
In-Reply-To: <20260701092850.1247010-1-zangyangyang1@xiaomi.com>
X-Headers-End: 1wqkOK-0001Gg-W3
Subject: Re: [f2fs-dev] [PATCH 1/2] fsck.f2fs: fix meta readahead after
 non-contiguous blocks
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
Cc: Yangyang Zang <zangyangyang1@xiaomi.com>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 7/1/26 17:28, Yangyang Zang wrote:
> When the current block is not contiguous with the in-progress readahead
> range, f2fs_ra_meta_pages() issues the pending range but keeps the old
> start block and length.
> 
> As a result, the current block is not included in any readahead range,
> and subsequent non-contiguous blocks keep reissuing the stale range
> instead of starting a new one.
> 
> Reset start_blk and len after issuing the pending range so readahead can
> continue from the current block.
> 
> Signed-off-by: Yangyang Zang <zangyangyang1@xiaomi.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
