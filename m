Return-Path: <SRS0=+fGn=4A=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 309F7C2BA83
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 12 Feb 2020 05:55:32 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00E352073C
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 12 Feb 2020 05:55:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="fWssI43D";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="AH5S92tF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00E352073C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1j1kzj-0000Fs-2j; Wed, 12 Feb 2020 05:55:31 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <viro@ftp.linux.org.uk>) id 1j1kzh-0000Fh-Jy
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 12 Feb 2020 05:55:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Sender:In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tVWWvoDZAgwKcsY1mlpUXPh9b/FAVENIRiV5AyTWJ8s=; b=fWssI43DiZQdsdLFid98fJJa6
 toK/eVjTBqMsd2VjyXfwMdKtDvXAsy2bvB78QcWZWjp/jXD7B7ZwaCuqHlbk8K3JR+xAJ8c+e+Yjc
 MZZ7a3JhiaWbZMS34WM+ws5NiAggv85oZG/sAWKNkhibAU2LIcwCGEtXymSw+zVH2Pdp0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Sender:In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
 Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=tVWWvoDZAgwKcsY1mlpUXPh9b/FAVENIRiV5AyTWJ8s=; b=AH5S92tF67BQ86Q4jqKBEQatiJ
 J3QmllO/qGWeh0iepoiX3ep6lhVku40j2B1SjEyLrQAEQFk1sAzclSonJkws6Hks1fbmagq96es9F
 H/Zw9gF1b1wvWqYSwo+x18nHYXOdFQbPxSags00UuoygO1Vra4takSbQhKhME/rtjIRk=;
Received: from zeniv.linux.org.uk ([195.92.253.2])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1j1kzc-009HfE-L7
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 12 Feb 2020 05:55:29 +0000
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat
 Linux)) id 1j1kzP-00BGKg-Vq; Wed, 12 Feb 2020 05:55:12 +0000
Date: Wed, 12 Feb 2020 05:55:11 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Eric Biggers <ebiggers@kernel.org>
Message-ID: <20200212055511.GL23230@ZenIV.linux.org.uk>
References: <20200208013552.241832-1-drosen@google.com>
 <20200208013552.241832-7-drosen@google.com>
 <20200212051013.GG870@sol.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200212051013.GG870@sol.localdomain>
X-Headers-End: 1j1kzc-009HfE-L7
Subject: Re: [f2fs-dev] [PATCH v7 6/8] f2fs: Handle casefolding with
 Encryption
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
Cc: kernel-team@android.com, Theodore Ts'o <tytso@mit.edu>,
 Daniel Rosenberg <drosen@google.com>, Jonathan Corbet <corbet@lwn.net>,
 Richard Weinberger <richard@nod.at>, Andreas Dilger <adilger.kernel@dilger.ca>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-fscrypt@vger.kernel.org,
 linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 Jaegeuk Kim <jaegeuk@kernel.org>, linux-ext4@vger.kernel.org,
 Gabriel Krisman Bertazi <krisman@collabora.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Tue, Feb 11, 2020 at 09:10:13PM -0800, Eric Biggers wrote:

> How about:
> 
> int f2fs_ci_compare(const struct inode *parent, const struct qstr *name,
> 		    u8 *de_name, size_t de_name_len, bool quick)
> {
> 	const struct super_block *sb = parent->i_sb;
> 	const struct unicode_map *um = sb->s_encoding;
> 	struct fscrypt_str decrypted_name = FSTR_INIT(NULL, de_name_len);
> 	struct qstr entry = QSTR_INIT(de_name, de_name_len);
> 	int ret;
> 
> 	if (IS_ENCRYPTED(parent)) {

oops.  parent->d_inode is unstable here; could have become NULL by that
point.

> 	if (quick)
> 		ret = utf8_strncasecmp_folded(um, name, &entry);
> 	else
> 		ret = utf8_strncasecmp(um, name, &entry);
> 	if (ret < 0) {
> 		/* Handle invalid character sequence as either an error
> 		 * or as an opaque byte sequence.
> 		 */

Really?  How would the callers possibly tell mismatch from an
error?  And if they could, would would they *do* with that
error, seeing that it might be an effect of a race with
rename()?

Again, ->d_compare() is NOT given a stable name.  Or *parent.  Or
(parent->d_inode).


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
