From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs-tools: Fix cross-build problem caused
 by AC_CHECK_FILE abuse
Date: Tue, 28 Aug 2018 11:44:09 +0800
Message-ID: <8acd7c28-5979-df91-0b2c-1ce206968b9e@huawei.com>
References: <20180828002941.7507-1-tytso@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1fuUvY-0000we-SX
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 28 Aug 2018 03:44:24 +0000
Received: from szxga07-in.huawei.com ([45.249.212.35] helo=huawei.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fuUvW-000Xfa-TC
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 28 Aug 2018 03:44:24 +0000
In-Reply-To: <20180828002941.7507-1-tytso@mit.edu>
Content-Language: en-US
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Theodore Ts'o <tytso@mit.edu>, linux-f2fs-devel@lists.sourceforge.net
Cc: Helmut Grohne <helmut@subdivi.de>

On 2018/8/28 8:29, Theodore Ts'o wrote:
> From: Helmut Grohne <helmut@subdivi.de>
> 
> f2fs-tools fails to cross build from source, because its upstream
> build system wrongly uses AC_CHECK_FILE. The purpose of the macro is
> checking for files on the host system. However here it is used to
> check whether a .git directory exists, which is a property of the
> build place. A simple "test -d" should be used here. After doing so,
> f2fs-tools cross builds successfully.
> 
> Addresses-Debian-Bug: #896909
> 
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
