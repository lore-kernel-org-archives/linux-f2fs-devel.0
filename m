Return-Path: <SRS0=6yzw=V6=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69AD4C433FF
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  2 Aug 2019 17:32:02 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37E3E217D7;
	Fri,  2 Aug 2019 17:32:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="imntZo9+";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="Bg+Di9Ea";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZcqdJ1sH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37E3E217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1htbPN-0000TA-Ey; Fri, 02 Aug 2019 17:32:01 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1htbPL-0000T1-Po
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 02 Aug 2019 17:31:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Yte0UDJB23zu/WxwyOZTwfCnjB/BtHTLGlSpj8csq/I=; b=imntZo9+cKTZGCtvaNy+UUrSGf
 QR/Qq9i9i1na3twbqNoEHlvFDGQvMU/4e7dmlSd6qZ0Sz+y+ll35z2N9zBJrjeJcAoBKSAREczJLJ
 QfL193391q33rRin5P1Ru9pxn9IbBg5ApcVStxJUv21O+a9y8dwfzS5J/1PXOMlGEnSY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Yte0UDJB23zu/WxwyOZTwfCnjB/BtHTLGlSpj8csq/I=; b=Bg+Di9EaNw0qbebpPy5/VwatmI
 yMcmZYHb/f/L/zaR7Ofv7zmosiZmyrxBmEd+QpioyUYZ4gsL7PXcB7jD2C8AeTax3iphZtmPRTTu2
 0n6zxw5tFpJJO9JgWq6b22u7FIMQDHSXtmvDnsWJ9C9BoZgeoBFSJpynV3gzPtpBMcds=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1htbPJ-007uhT-63
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 02 Aug 2019 17:31:59 +0000
Received: from gmail.com (unknown [104.132.1.77])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 31C1B2173E;
 Fri,  2 Aug 2019 17:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1564767111;
 bh=p28pesjeaFELdMWXTRb2eE2TRQRtp76oeifvbyCl/RI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ZcqdJ1sHgA4eHoVKYSn8SpVn+pAUEpj9uFNNG8Yop5svyGIeSKgDaCG0hU7/1xGe+
 YH6wiSFmAifvQSIcT5ECPJSv2MxBpI4U1tOb0SI7k4tFkU4lU056T/wtL7OaDANFff
 AXFhYpVcepiXq7WKPEIqg6WGV1t6hc/k/rdkPvQU=
Date: Fri, 2 Aug 2019 10:31:49 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Chao Yu <yuchao0@huawei.com>
Message-ID: <20190802173148.GA51937@gmail.com>
Mail-Followup-To: Chao Yu <yuchao0@huawei.com>,
 linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-mtd@lists.infradead.org, linux-api@vger.kernel.org,
 linux-crypto@vger.kernel.org, keyrings@vger.kernel.org,
 Paul Crowley <paulcrowley@google.com>,
 Satya Tangirala <satyat@google.com>
References: <20190726224141.14044-1-ebiggers@kernel.org>
 <20190726224141.14044-15-ebiggers@kernel.org>
 <e3cf53a7-faf2-0321-22de-07d2e2783752@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e3cf53a7-faf2-0321-22de-07d2e2783752@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Headers-End: 1htbPJ-007uhT-63
Subject: Re: [f2fs-dev] [PATCH v7 14/16] f2fs: wire up new fscrypt ioctls
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
Cc: Satya Tangirala <satyat@google.com>, linux-api@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-fscrypt@vger.kernel.org,
 keyrings@vger.kernel.org, linux-mtd@lists.infradead.org,
 linux-crypto@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, Paul Crowley <paulcrowley@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Fri, Aug 02, 2019 at 04:10:15PM +0800, Chao Yu wrote:
> Hi Eric,
> 
> On 2019/7/27 6:41, Eric Biggers wrote:
> > From: Eric Biggers <ebiggers@google.com>
> > 
> > Wire up the new ioctls for adding and removing fscrypt keys to/from the
> > filesystem, and the new ioctl for retrieving v2 encryption policies.
> > 
> > FS_IOC_REMOVE_ENCRYPTION_KEY also required making f2fs_drop_inode() call
> > fscrypt_drop_inode().
> > 
> > For more details see Documentation/filesystems/fscrypt.rst and the
> > fscrypt patches that added the implementation of these ioctls.
> > 
> > Signed-off-by: Eric Biggers <ebiggers@google.com>
> 
> Reviewed-by: Chao Yu <yuchao0@huawei.com>
> 
> BTW, do you think it needs to make xxfs_has_support_encrypt() function be a
> common interface defined in struct fscrypt_operations, as I see all
> fscrypt_ioctl_*() needs to check with it, tho such cleanup is minor...
> 

Maybe.  It would work nicely for ext4 and f2fs, but ubifs does things
differently since it automatically enables the encryption feature if needed.
So we'd have to make the callback optional.

In any case, I think this should be separate from this patchset.

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
