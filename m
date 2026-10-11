Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98953CA9EBD
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 11 Oct 2026 10:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WaBYRJTzmQGXfISxlSQDZRo6dIoFKWBdcHdIUQxAZNA=; b=h1xRBa8QpYd882BKPY/aDRb6eW
	L91S1cnhLzaI2yjM+ugUGMf83UPuWaTUCjGgKfAxDGKVNrICFK5ugGHGzgwi1OH71oN39JFwOXRNT
	JbVMBArabNb3pSviJeHmItvnkpyWB4bx23HLhFegT6sAclfPk7Max+QnX9y3g2SmfW5U=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xFqwR-0003GS-11;
	Sun, 11 Oct 2026 10:38:07 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1xFqw3-0003Fx-D4
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 11 Oct 2026 10:37:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 References:Cc:To:Subject:From:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=aN1XZ4lOE8V26VbbVSWEWoGRS0e1EVgJSZ/u1bHCotY=; b=UYDUYV8fFsN2x4ahVPH0euFkO4
 +pBseWEhiHH6xI0zlJxonP46BOJW3nq5BdjwjsRkfmaVJ7LO/5s/CCns88ERJstjEQePTEulfxN3x
 7i0KJfnGP9laDCd6fNMcEIgHTE9+Yfz9kCzS4dKsXmILlmppFB7GAGD3LPF8sGrPXZEA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Cc:To:
 Subject:From:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=aN1XZ4lOE8V26VbbVSWEWoGRS0e1EVgJSZ/u1bHCotY=; b=a5L3So0DLHlWjzFj+DuKEa+Vqn
 Sd1EafFPpZxv4G+7gxxZpA9vkXKRt6TeVSL3Yd1BTYaVOoneQIVY7kkzdRXhB5971i+O8btR8OFRV
 Uq18j4yKt4OrWOtsDtFvSADmChVLcAWQNMkUWpZgIJIO5j0Vav19pkHyCw2lxhCfB5W0=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xFqw3-00017G-Mx for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 11 Oct 2026 10:37:44 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3FB1C40BB4;
 Sun, 11 Oct 2026 10:37:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 488671F0089B;
 Sun, 11 Oct 2026 10:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791715058;
 bh=aN1XZ4lOE8V26VbbVSWEWoGRS0e1EVgJSZ/u1bHCotY=;
 h=Date:From:Subject:To:Cc:References:In-Reply-To;
 b=aciRz+b3zZ+Si/gIdLVMQHRh+GFtNhhs8SvCoODTog5yKOUGvu7yWr1KeR6frCw0Q
 EK5Hln2Hd+e9PhaposO2AglYSV3/sV680n3KuQnVMHNcKYYhw11CO11mRtBNujK/yi
 dRR1tW5mWaswX6OaM9gYJ7njaclg+VrELMijjNGSeSVFwIAy8XwX6yMj0gujT9p/3l
 kxpD969xT3IjSv8gAetDLBOmjUCXKlp8o7gjMEiKRn0KHZmpgybSRHxU3vBAO/tibN
 /dXhZ5POW2oJWsSwrezJdCxW47djk08Q7IC0cSQ1U7Ttqtgb/NMKAHLEYtrN/wB9bz
 vK47A6VFGYWFA==
Message-ID: <73918f53-cf62-4a0f-a28f-a34dfd7de2de@kernel.org>
Date: Sun, 11 Oct 2026 18:37:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Seongjae Jeong <jsjlee1020@gmail.com>, jaegeuk@kernel.org
References: <20261010074912.114840-1-jsjlee1020@gmail.com>
Content-Language: en-US
In-Reply-To: <20261010074912.114840-1-jsjlee1020@gmail.com>
X-Headers-End: 1xFqw3-00017G-Mx
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix termination of
 f2fs_sync_meta_caches()
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

On 10/10/26 15:49, Seongjae Jeong wrote:
> When __f2fs_write_meta_cache() returns false in f2fs_sync_meta_caches(),
> the function only exits the inner loop instead of the entire
> while loop. This leads to an unnecessary lookup of the next batch.
> 
> Also, when nwritten >= nr_to_write, only the inner loop terminates.
> This allows the function to continue processing subsequent batches
> after the writeback budget has been reached.
> 
> Terminate the entire while loop in both cases to avoid unnecessary
> batch lookups and respect the writeback budget.
> 
> Signed-off-by: Seongjae Jeong <jsjlee1020@gmail.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
