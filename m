Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D4FCCD8CB9
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 10 Jun 2026 12:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iV39tnuL+su6zqRatuPFW7gzAcKGMjYCX4WL5RZSIl0=; b=RnMMNysAho5rj/HPBaksK0cseC
	nDw3eQLINLNVAmsk0W/0XAtU2M9dnZO2huuYHQiDd4QUe9pFTsBRouBAZarED4cgTyJkuFoXJJN5m
	2K8wA1lMYzAgXNiaDyazPJl1ltwgRRhc3LdZqz2lf83eUaFhPDvSOeyxwE2O8Hlw2xyM=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wXHlG-0005NJ-N3;
	Wed, 10 Jun 2026 12:10:23 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wXHlB-0005N4-2i
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 10 Jun 2026 12:10:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/OH5+E8NuGLgpHG3Uwvo6VB+OMw2Wl6vqLZbLuDL42w=; b=KQ3p7tIrzjKGMLaZhJcgSLkFbI
 g81Epzcg3DX0MJRcDycx+rzMOO1OPhlZziTJIMCZcTNl1PbjaXCxWLHwM2EnwqFCgpgYIO8Bax5l9
 6Z53KQRbRfuWxBowqnRp7DNI40Qe6zwrRvFITKS/LryWvrcZvf2a78ynXBHG9ZP6XwRs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=/OH5+E8NuGLgpHG3Uwvo6VB+OMw2Wl6vqLZbLuDL42w=; b=Rsl0NF1cdj/LkOPWMidx3CZrgO
 pBvLqlEAQ6UE8tE8zm6VORB9b7n13t2LA2QvH3tbtUdsQX45loz/hmCPgrhXEEB4jF0hopEz022Vy
 tIfauyInjrS4ay+XS5hMlTlD8lptdw+zMyilydwT293avn/h8tTvvIf5nzSLtpqr37sA=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wXHl8-0004Gt-MX for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 10 Jun 2026 12:10:17 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 873346020A;
 Wed, 10 Jun 2026 12:10:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 500C01F00893;
 Wed, 10 Jun 2026 12:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781093409;
 bh=/OH5+E8NuGLgpHG3Uwvo6VB+OMw2Wl6vqLZbLuDL42w=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=JEdM7/f1HcT1MidBDZr9/pAdkwRnQXYzNQARCaDL9LLOadmX3bNvKQ2K/+g514pXN
 f9qPjL2qBiwNOclHIGLGm1XoJ0jozTaFRtfCt1rHbBPd5cSMEWzH+am33w7fvqSYb2
 cU0nAN9xSnm51uhAfC6UmmomqAcdOpzJjfjpXoGegQ4QqhIQduxh3btddXWoyRMQPC
 DzHlM25FZJpIZ+dyGfbdjNrF66Ab+1GOhl7cx9hTJ8K2V2FIsM4sQ6DMgTSQH1BGGw
 3xNuAZDQF9jEM6ida0v9y9w8cewJ6slRSs2n5uA/53uDWHf8Enqk2O+ZvdJzIxu78D
 EHzEGZj7fS8NQ==
Message-ID: <326d8403-717d-4479-8ecc-d598de7c9000@kernel.org>
Date: Wed, 10 Jun 2026 20:10:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Bart Van Assche <bvanassche@acm.org>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <cover.1780003055.git.bvanassche@acm.org>
 <60ab44127999ea22ca05aa6c552f305bfaef9898.1780003055.git.bvanassche@acm.org>
Content-Language: en-US
In-Reply-To: <60ab44127999ea22ca05aa6c552f305bfaef9898.1780003055.git.bvanassche@acm.org>
X-Headers-End: 1wXHl8-0004Gt-MX
Subject: Re: [f2fs-dev] [PATCH 1/4] f2fs: Prepare for supporting delayed bio
 completion
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 5/29/26 05:20, Bart Van Assche wrote:
> Use bio frontpadding to allocate memory for a work_struct when
> allocating a bio.
> 
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
