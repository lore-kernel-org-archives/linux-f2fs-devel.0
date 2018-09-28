From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH] generic: add a testcase to test uid/gid
 recovery
Date: Fri, 28 Sep 2018 20:28:23 +0800
Message-ID: <20180928122823.GG17817@desktop>
References: <20180925084558.77190-1-yuchao0@huawei.com>
 <ab6235fd-ea62-59d4-246c-9b73bc3983f3@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <guaneryu@gmail.com>) id 1g5rst-0007Bo-4J
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 28 Sep 2018 12:28:39 +0000
Received: from mail-pf1-f195.google.com ([209.85.210.195])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1g5rsr-00DMPh-N2
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 28 Sep 2018 12:28:39 +0000
Received: by mail-pf1-f195.google.com with SMTP id k21-v6so4222348pff.11
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 28 Sep 2018 05:28:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <ab6235fd-ea62-59d4-246c-9b73bc3983f3@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <yuchao0@huawei.com>
Cc: fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On Tue, Sep 25, 2018 at 05:16:31PM +0800, Chao Yu wrote:
> Hi Eryu,
> 
> There are several fields in inode rather than uid/gid didn't recover in
> f2fs, I'm not sure we need to cover all of them with one generic testcase,
> or with several testcases. Any suggestion?

Sorry for the late response!

Several targeted test cases would be fine.

Thanks,
Eryu
