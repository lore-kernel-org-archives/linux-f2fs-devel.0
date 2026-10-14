Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F3F9CC6B1A
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 14 Oct 2026 10:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kfE83LR8Y9P6VCvam7/+vhjf2mWDDPiOoRRGSTxc42Q=; b=RlQOi/Hn8Ah9vdkytALkXyyUTj
	yPhDa5zwVQWYc8U9c/B7yQB8OzH8SplWtUwAs4Yz4pDKZgIKqfK7EjZlFCFarHP44yv/6ktzV/zb6
	2o7WPBuLP337+5ZHYCvHIQ43uzHwvM1AlxeZMETX1asvpPZw4j3heWk0EyQV1292mOoo=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xGwbI-0006JF-4t;
	Wed, 14 Oct 2026 10:52:48 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1xGwbG-0006J8-Ht
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 14 Oct 2026 10:52:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NKhbfG21Z6/FzNEFvz7vS0kzsDAM2Sa2ghF/D3xZUdc=; b=Hs8M0LMO6JuCl7g8bM2paQcDJi
 3WtY9d7Sav9djrrgm7MMng7hPIRUtblnKx9Uy9eBwnZv85O0T+w/eFkD6nBTmmfeeFMyScGs3spQP
 qO1MQcUZgBrssa8y0P64xAHNXjjpW3bOLFKLf+Yt75jVwkGzeP603M/SJ5xY0wZmGrAk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=NKhbfG21Z6/FzNEFvz7vS0kzsDAM2Sa2ghF/D3xZUdc=; b=OYn3EagJshDGMEaR8RvPj1nCPK
 gRZLQ6sncTnlEUEaNBLeuib+koukxK/IEnS0BJZmwOC521Ad4nmM1AV83LPOgKJ/IJH3QLh/dW/m7
 5q5vjQNU6X54Qg/V2QF7DCjPAqyquRnSu5Ij9yBrfKAuMkeDSRd63GSrKYi8Sz9Wb9ak=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xGwbD-0006KP-Nn for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 14 Oct 2026 10:52:46 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2198660219;
 Wed, 14 Oct 2026 10:52:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C55811F000FF;
 Wed, 14 Oct 2026 10:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791975157;
 bh=NKhbfG21Z6/FzNEFvz7vS0kzsDAM2Sa2ghF/D3xZUdc=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=XTcwNe8/SMQO+bKr4pfjj/+Hq6GM3fKAgAd2rALloMVNC+n/a52y2yhIQN0GJhNlW
 wRz7LgZWxo2yw5Anuhb0eMVaTTpYXHZvHw1VbZmujYztSTd9+iWUeAsYxwWtRuWxFi
 oBKv5IYODoYbE7E8FOIBOkKoswkNE486l06CmySiSLHZ1+8mMCbDe6XO0C6fEqwszp
 IAoGKzsZ66hMqZCibC7EF+SjM/TRaF2RQAs/4OdtbdpowXuKoSMb77r3zKTZ+VU6DQ
 78XQL0DVPy5Sc8QEr1qfLkkGpCXu4EdHwy4xCqfm7xqVqsjzqnBTqkZPLUh1kpTjjC
 QbvUAePLdepuw==
Message-ID: <320a0790-c6fe-4da9-bb77-4490e88946ef@kernel.org>
Date: Wed, 14 Oct 2026 18:52:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jan Prusakowski <jprusakowski@google.com>, Zorro Lang <zlang@kernel.org>, 
 fstests@vger.kernel.org
References: <20261009085544.2450966-1-jprusakowski@google.com>
Content-Language: en-US
In-Reply-To: <20261009085544.2450966-1-jprusakowski@google.com>
X-Headers-End: 1xGwbD-0006KP-Nn
Subject: Re: [f2fs-dev] [PATCH v2] generic/622: increase sleep time for
 lazytime expiration
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
Cc: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 10/9/26 16:55, Jan Prusakowski wrote:
> In generic/622, expire_timestamps() tests whether lazytime timestamp
> updates are persisted after dirtytime expiration. It configures
> dirtytime_expire_seconds to 1 second and enables continuous writeback
> of dirty inodes, followed by sleeping for 2 seconds to allow the
> asynchronous VFS flusher thread to expire the I_DIRTY_TIME inode,
> invoke the filesystem's write_inode callback, and flush the dirty
> metadata before the test executes _scratch_shutdown -f.
> 
> However, on filesystems or configurations with higher writeback
> overhead -- such as F2FS with transparent compression enabled, where
> compressed files cannot use inline data and writes use out-of-place
> updates (OPU) with higher latency in the compression and writeback

FYI, I encounter similar issue on non-compressed inode, so v2 w/o checking
compression makes sense to me.

> pipeline -- the 2-second sleep window can occasionally be insufficient.
> Because the inode is only eligible for expiration after 1 second, only
> about 1 second remains in the 2-second sleep window for the flusher
> thread to schedule, expire the inode, and mark the inode page dirty
> before restore_expiration_settings resets dirtytime_expire_seconds to
> 24 hours and shutdown occurs. If the flusher thread is delayed, the
> subsequent shutdown checkpoint ignores the unexpired I_DIRTY_TIME inode,
> causing the test to intermittently fail with:
> 
>     FAIL: lazytime mtime wasn't persisted by expiration
>     ondisk_time (...) != expected_time (...)
> 
> Increase the sleep duration in expire_timestamps() from 2 to 4 seconds
> to give sufficient margin for the flusher thread to reliably expire the
> lazytime inode and dirty the inode page before shutdown.
> 
> Signed-off-by: Jan Prusakowski <jprusakowski@google.com>
Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
