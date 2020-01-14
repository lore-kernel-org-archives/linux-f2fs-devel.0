Return-Path: <SRS0=YoBC=3D=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2113DC33CA9
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 14 Jan 2020 00:14:24 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D38BA2084D;
	Tue, 14 Jan 2020 00:14:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="A3WDtL2e";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="RROlYOJo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D38BA2084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1ir9qh-0005Nk-3C; Tue, 14 Jan 2020 00:14:23 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <tytso@mit.edu>) id 1ir9qf-0005NV-Kw
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 14 Jan 2020 00:14:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KM2l9QyIZRoILZJtRs+biVQwMOKhP43uRtd2/GEe+bc=; b=A3WDtL2e5ber8GU8rBEHyCR6uH
 l1PmhpwqVtQDyZDzDwN2gRgpQmmWbF+/OluRN9MPIESsbNYbzZjZuQXgNoo+nRkOiHtpzt7zLBPhC
 D2JkAprp5B+kfkfz9M8028VY6jUkn8w/915atLPu4o6iIAzaxqc23ASNgj200k08cp4g=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=KM2l9QyIZRoILZJtRs+biVQwMOKhP43uRtd2/GEe+bc=; b=RROlYOJom/s9zsdVwiYrLN52Kn
 ThvtGA1ee2xrNdUkjlWUfiwVjx15l+HSTOh3ylOnBTUVyaIlIJAfCIJBSfACYYQzs/nG4aA6yFkeB
 eY4d+KySb2HH+xK426pFRK2Ta6BtVx5+/CqfcFc4oDTdbK4Tb9/0IT21ozpnbGAUgFlY=;
Received: from outgoing-auth-1.mit.edu ([18.9.28.11] helo=outgoing.mit.edu)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1ir9qe-001djC-2A
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 14 Jan 2020 00:14:21 +0000
Received: from callcc.thunk.org (guestnat-104-133-0-111.corp.google.com
 [104.133.0.111] (may be forged)) (authenticated bits=0)
 (User authenticated as tytso@ATHENA.MIT.EDU)
 by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 00E0E7YN032266
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 13 Jan 2020 19:14:08 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
 id AB74C4207DF; Mon, 13 Jan 2020 19:14:07 -0500 (EST)
Date: Mon, 13 Jan 2020 19:14:07 -0500
From: "Theodore Y. Ts'o" <tytso@mit.edu>
To: Eric Biggers <ebiggers@kernel.org>
Message-ID: <20200114001407.GO76141@mit.edu>
References: <20200106205533.137005-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200106205533.137005-1-ebiggers@kernel.org>
X-Headers-End: 1ir9qe-001djC-2A
Subject: Re: [f2fs-dev] [PATCH v2] fs-verity: implement readahead of Merkle
 tree pages
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
Cc: linux-fsdevel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
 linux-ext4@vger.kernel.org, Victor Hsieh <victorhsieh@google.com>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Mon, Jan 06, 2020 at 12:55:33PM -0800, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> When fs-verity verifies data pages, currently it reads each Merkle tree
> page synchronously using read_mapping_page().
> 
> Therefore, when the Merkle tree pages aren't already cached, fs-verity
> causes an extra 4 KiB I/O request for every 512 KiB of data (assuming
> that the Merkle tree uses SHA-256 and 4 KiB blocks).  This results in
> more I/O requests and performance loss than is strictly necessary.
> 
> Therefore, implement readahead of the Merkle tree pages.

Looks good.   Feel free to add:

Reviewed-by: Theodore Ts'o <tytso@mit.edu>

(for the ext4 and fs/verity bits)



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
