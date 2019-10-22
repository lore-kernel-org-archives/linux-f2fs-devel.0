Return-Path: <SRS0=7Gzg=YP=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFF92CA9EA0
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 22 Oct 2019 05:27:24 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8124F2075A;
	Tue, 22 Oct 2019 05:27:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="F9eBwnEr";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="U+JEf8YO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8124F2075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fromorbit.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1iMmhY-0008Pi-4E; Tue, 22 Oct 2019 05:27:24 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <david@fromorbit.com>) id 1iMmhX-0008Pb-KQ
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 22 Oct 2019 05:27:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=i338/Py5PICs9dJcJFQqyvQ3vTLCgBjcZGAJYAjuHIM=; b=F9eBwnErPob3MKfLNFmf0PSN+K
 A26eflw+4H8phcn0YviaNy64efGPlXlg5DnzDzvv2jaOO9XQ3apcq+OvS9lZwqkXp0D33jZIG6ymx
 +7t8CUXedheIPExSb+ETI533ccN9RyQCMdKDFzRhiHR1U1Q0kMttLTjzVhTFfV5qOo4c=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=i338/Py5PICs9dJcJFQqyvQ3vTLCgBjcZGAJYAjuHIM=; b=U+JEf8YOjVVtdVtBbYuldIKZKO
 DnOChh6cUTDppgSC4RfWfWbDDVB1fwZ21GrwNPss8pw2/eXetIWNLMV6EJE0l3/BrKgRjYIVc44LG
 EYvC/XU0kFpeJ6uIMVVfuTrW+R8TgIYCGowCLUzLABKEDRYU9BY0H4AxKSQshfQO/PXg=;
Received: from mail104.syd.optusnet.com.au ([211.29.132.246])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtp (Exim 4.92.2)
 id 1iMmhV-00GR9b-Mg
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 22 Oct 2019 05:27:23 +0000
Received: from dread.disaster.area (pa49-180-40-48.pa.nsw.optusnet.com.au
 [49.180.40.48])
 by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 95C8A43ED8B;
 Tue, 22 Oct 2019 16:27:14 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
 (envelope-from <david@fromorbit.com>)
 id 1iMmhM-0000ft-TN; Tue, 22 Oct 2019 16:27:12 +1100
Date: Tue, 22 Oct 2019 16:27:12 +1100
From: Dave Chinner <david@fromorbit.com>
To: Eric Biggers <ebiggers@kernel.org>
Message-ID: <20191022052712.GA2083@dread.disaster.area>
References: <20191021230355.23136-1-ebiggers@kernel.org>
 <20191021230355.23136-2-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191021230355.23136-2-ebiggers@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=D+Q3ErZj c=1 sm=1 tr=0
 a=y881pOMu+B+mZdf5UrsJdA==:117 a=y881pOMu+B+mZdf5UrsJdA==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=XobE76Q3jBoA:10
 a=1XWaLZrsAAAA:8 a=7-415B0cAAAA:8 a=u2WIiwEpneD56I5pijMA:9
 a=5WK52ldy0EvilltI:21 a=YrdWnVge8_36jD4u:21 a=CjuIK1q_8ugA:10
 a=biEYGPWJfzWAr4FL6Ov7:22
X-Headers-End: 1iMmhV-00GR9b-Mg
Subject: Re: [f2fs-dev] [PATCH 1/3] fscrypt: add support for
 inline-encryption-optimized policies
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
Cc: linux-f2fs-devel@lists.sourceforge.net, "Theodore Y . Ts'o" <tytso@mit.edu>,
 Satya Tangirala <satyat@google.com>, Paul Lawrence <paullawrence@google.com>,
 linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Jaegeuk Kim <jaegeuk@kernel.org>, linux-ext4@vger.kernel.org,
 Paul Crowley <paulcrowley@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Mon, Oct 21, 2019 at 04:03:53PM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Some inline encryption hardware has only a small number of keyslots,
> which would make it inefficient to use the traditional fscrypt per-file
> keys.  The existing DIRECT_KEY encryption policy flag doesn't solve this
> because it assumes that file contents and names are encrypted by the
> same algorithm and that IVs are at least 24 bytes.
> 
> Therefore, add a new encryption policy flag INLINE_CRYPT_OPTIMIZED which
> causes the encryption to modified as follows:
> 
> - The key for file contents encryption is derived from the values
>   (master_key, mode_num, filesystem_uuid).  The per-file nonce is not
>   included, so many files may share the same contents encryption key.
> 
> - The IV for encrypting each block of file contents is built as
>   (inode_number << 32) | file_logical_block_num.
> 
> Including the inode number in the IVs ensures that data in different
> files is encrypted differently, despite per-file keys not being used.
> Limiting the inode and block numbers to 32 bits and putting the block
> number in the low bits is needed to be compatible with inline encryption
> hardware which only supports specifying a 64-bit data unit number which
> is auto-incremented; this is what the UFS and EMMC standards support.

These 32 bit size limits seem arbitrary and rules out implementing
this on larger filesystems. Why not just hash the 64 bit inode, file
offset and block numbers into a single 64 bit value? It is still
unique enough for the stated use (i.e. unique IV for each file
block) but it doesn't limit what filesystem configurations can
actually make use of this functionality....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
