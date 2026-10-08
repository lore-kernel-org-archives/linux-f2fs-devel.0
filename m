Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7226BCA6007
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  8 Oct 2026 09:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:Message-ID:Date:In-Reply-To:References:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CE2BlrmRimF8rnhC4Wj97s/LOi8Y+jm591MD6MkayHQ=; b=OLqZOWtJkupur0++x7641UEgzN
	rMaOG2KqTIS6jnmqklWbz2pS8nKYMQR+geXfMa8qpzBzB0ANS6j0MT3o0PetHSeXth+hjI0ySrSSt
	B6lhvvWPTHN6FM2CI3CSASp73V+onc5TtSZEXKPhALL1tnD8/qSqRx1lZnRBVE25yTVs=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xEkpN-0003Qd-2C;
	Thu, 08 Oct 2026 09:54:14 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jprusakowski@google.com>) id 1xEkpM-0003QV-C2
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 08 Oct 2026 09:54:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:Subject:Message-ID:Date:From:
 In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-Transfer-Encoding
 :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=pfh4IAK+hk+AqpWfVdWMlr9/Ce13+Dj7dKdKxg+Obqo=; b=kLLjivZu8BUrW5Y5Q7O6EkMHO/
 8qlySyWrQVVVIKROQdNKTJKpD3xW/V0ebIJ2F5FItKOeFwwJxdvOLkogYQvfrGxJZCdhz/0Lz9xme
 nmMsc8uihLYiA6io1emc7lk6Pgoueb4idaG6Vw/pbXXJEZtMRtdMwOislT5MJVCtCx8c=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
 MIME-Version:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=pfh4IAK+hk+AqpWfVdWMlr9/Ce13+Dj7dKdKxg+Obqo=; b=aorw2WWPTrIWbgvRMp2ntRAbB9
 CnV+rZri4my1/DdbM55FgL3ND1fBZ96TXt6xmLjmCrupkU1+z2f318i5ENOIap+WySwWumoqnrvZQ
 oQUo99uGAPyVn6xxKeXLonYZ8rkcAQvPZWTUiL3+oM4JOssOgqVNA7vsX/BN3evRV/ew=;
Received: from mail-qt1-f173.google.com ([209.85.160.173])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xEkpJ-0001sy-Hf for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 08 Oct 2026 09:54:13 +0000
Received: by mail-qt1-f173.google.com with SMTP id
 d75a77b69052e-5337c7b9937so256141cf.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 08 Oct 2026 02:54:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791453247; cv=none;
 d=google.com; s=arc-20260327;
 b=arEGkvva7e1AST3PFwBiwunczynzyhKc0Ynm0Y2L3snkJJC9tw8HFFx3nVQ92qdAs2
 KA11Rfzr4kehf2qVp5Cc5NipjPiqLbLyy4QGvxUUqCeYv5QPmGeohIjQv4ZnXUQzxlC9
 RO35z4KVYVgcWb1X9DdXmUzDoQbmNaOsPzokygBV+UkZwBM57P13Y0d7E8TdyZteIJgM
 ROJ9MeunEqb/YOlxFDzMlUTMoUeQVPK63ODR1VHYE57ffAIEyAyYBTKrVH5jOaAp7rRn
 e6n/A3MP57DLjsdOpndd6my9V8Jy+3xSnJf4QZTa/dg7c0VaHIs4dstlbE7QXFwjo3to
 38WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=pfh4IAK+hk+AqpWfVdWMlr9/Ce13+Dj7dKdKxg+Obqo=;
 fh=sBIgjG005G36QM3CVLOMh74+5zgJ0kIC6htXeYjTGaE=;
 b=MtuZFE5FDzQoFX+FVQ/7AnQN6wEqH3SZmeirlHhH/LhbusroHeu04vSgT/DGfLXBen
 1DxU+H5BNOvGFwCh8P1GBzR62rb0lTq+Q408gPUqVI55zVUgauXg6BfCTWFEGEhW1FQQ
 N4+6O1PBJ/YXuqHVaO7LW6DEydObNPLwUZ5dJhtvOksvjeBGjKcjocF1yB1mLqmeUgUw
 CuZJ7gBPf0gvJkwkdNVFyimstA+iy7JOuYAYdBi8WnsAfc+GeVq9lFcyJcYUkFZjut1A
 5lIS4q2L+xFb4DUikk+0t7SN8RlLYjv5AWgABn27KJW5ull8mm+JxHR33PnCiqLK+t0Y
 +ZBA==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1791453247; x=1792058047;
 darn=lists.sourceforge.net; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=pfh4IAK+hk+AqpWfVdWMlr9/Ce13+Dj7dKdKxg+Obqo=;
 b=VRDfwN658HdlTJy7cWcMBigQFdDTEjnk9gBJGZdzWBX13uTFLVe/SXFVN6kbbRmxlC
 W958CmmmdCNUQoXXqiALM15oHnWulexa9/qSH44+Xm5MDeZL4Q65/Eq7BjdMtJBytwEa
 PbaqB9v6RL87qLJWTyaRB1K+sdiTw4opaf3CIVK3i25eiQE30MpoLmmfEbOjP3Lqhj4l
 3d+odsPbREZTFlXa9rIvnWH70avATKOU4kXm/A4iJ8JRgF/77z//Kke59uU7LB89cSKV
 H+1go3sMNzfc53m71fwDVIz9wQDJWZHpf8i3snSz3KsNJOu3tfy/hAJwWqn/Y84TSt/B
 txog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791453247; x=1792058047;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=pfh4IAK+hk+AqpWfVdWMlr9/Ce13+Dj7dKdKxg+Obqo=;
 b=pWFQJVvYmqkhiefLmCL25yn5X7aWQ09JaC3hvqWTvhRJq3aOnOPu/JArnVQwtkygEd
 +8B3RbmLPzOB0M8MPIjGtyfctqTNQYg/RSDZD9ukuVqm7nxqHnRq+TI3IiT+kcg+4Arw
 6lF1qYi8Za7C2ciaU6RYAV2PB8RUB1x48lAdepyoNyafNbfe1IDVVM0WVojpQn8lew36
 VMxr/A2JWQSzJggJEguPP1lsOB71XVZvdx7fNibjr3ACZ6xmRmLcVTtFJM6OY33lOpz6
 gJstLsu19l2HFBObce4CiSgj8azShr7LY2nkE6hyRKKRc1lUYbwJsAVRZJjDTtjCNKh+
 7t3A==
X-Forwarded-Encrypted: i=1;
 AKwUvByhgO2ABs1ZMo8nyuX5DBdiyiS0DfbvXoMDkn2r18rYmOAoeCJDTzwL/gdGusrJIwLIEO5GcUocEfUFPdeWK6Tj@lists.sourceforge.net
X-Gm-Message-State: AFuF++n5FK1iZdPRLtBqVZafp+1KBCnW38t/adm3fD2L2BRXJTBX40+g
 4g9A0GbS1kfTY9/HRGbMQQsCQNaZaHuShDrKFaIitcgx4MBLkn6mG7m3QYDEWSY8HgD7DGeGtti
 L4DuVd2c+qLx1YUmHbUefPVo3sZ45Z2AmxMj2Vg9R
X-Gm-Gg: AYBFou3fsWH2pbltV9Wa2dhLfhoIhMsaY+kXq+pgVBuloxgilKYqMqehJ69Vvy0EdpB
 YJrCv9Sie5pJ0TYnUw5a83YIKZUgaI2xcmVvAn5f+7fHfp2ugJ8GHyXLak9lSX/I0dRTOJRBnuM
 KPfczDa0xX8bJNhHqJrnM1DS+ltuEsow9GGW1eNCE50qJfrK06AVIaz4SjSf4zX9/PDE2VQSQKu
 rqjw0JJGIVtW8/gvjsC0iixsJ0C6MpLmSfEpmmeMTLLD40rPndAxQJJUm0gLdPtFzKUtXO0G2dP
 Y3c3AOOTmWbST+2TTCu8jZUfV256kKAh39mrKaXG3FHRs1ZMoxSysgjuoxnFb+PDsmnc6v/dwqf
 egMiYkxhD9P4s9w==
X-Received: by 2002:a05:622a:5a13:b0:532:9220:a9ae with SMTP id
 d75a77b69052e-5358a085ee2mr15530731cf.6.1791453246927; Thu, 08 Oct 2026
 02:54:06 -0700 (PDT)
MIME-Version: 1.0
References: <20261008093317.2792726-1-jprusakowski@google.com>
 <asdkTCwh9hW5gkEJ@infradead.org>
In-Reply-To: <asdkTCwh9hW5gkEJ@infradead.org>
Date: Thu, 8 Oct 2026 11:53:54 +0200
X-Gm-Features: AclHuK-VcO99yoe7ZhiCBiJq7TbGRhqmRi7Ao2zlUaErLuv7hcSeESthDFpmc4U
Message-ID: <CAHwWncjqdUStXZqm5Bv9DD-HGFPvjA5csp5DKT0Mdo3QR118-A@mail.gmail.com>
To: Christoph Hellwig <hch@infradead.org>
X-Headers-End: 1xEkpJ-0001sy-Hf
Subject: Re: [f2fs-dev] [PATCH] generic/622: increase sleep time for
 lazytime expiration on compressed f2fs
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
From: Jan Prusakowski via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Jan Prusakowski <jprusakowski@google.com>
Cc: jaegeuk@kernel.org, Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

> Please just increase the timeout unconditionally and add a comment
> explaining it.  While there are some historic hacks like this, generic
> tests really should not have file system specific conditionals.
>
> > Change-Id: I208bf14c189b54cc209059b0fd2de9e403a073f2
>
> And please don't add useless not-standard patch trailers.

Thanks, I'll send a V2 shortly.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
