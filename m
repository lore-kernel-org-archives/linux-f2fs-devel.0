From: Ju Hyung Park <qkrwngud825@gmail.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: Fix bool initialization/comparison
Date: Sat, 7 Oct 2017 23:33:54 +0900
Message-ID: <CAD14+f2qcTmYa066cNFOkSycsAHaCcc+q_63U75Jv=0y49_YhA@mail.gmail.com>
References: <1507383097081-778026979-0-diffsplit-thomas@m3y3r.de> <1507383097084-400953728-9-diffsplit-thomas@m3y3r.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1507383097084-400953728-9-diffsplit-thomas@m3y3r.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Meyer <thomas@m3y3r.de>
Cc: "jaegeuk@kernel.org" <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Isn't this bogus?

"bool" type in Linux kernel is a typedef to "_Bool"
and true/false is defined as 1 and 0 by enum at include/linux/stddef.h.

On Sat, Oct 7, 2017 at 11:02 PM, Thomas Meyer <thomas@m3y3r.de> wrote:
> Bool initializations should use true and false. Bool tests don't need
> comparisons.
>
> Signed-off-by: Thomas Meyer <thomas@m3y3r.de>
> ---
>
> diff -u -p a/fs/f2fs/data.c b/fs/f2fs/data.c
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -419,7 +419,7 @@ next:
>         bio_page = fio->encrypted_page ? fio->encrypted_page : fio->page;
>
>         /* set submitted = 1 as a return value */
> -       fio->submitted = 1;
> +       fio->submitted = true;
>
>         inc_page_count(sbi, WB_DATA_TYPE(bio_page));
>
>
> ------------------------------------------------------------------------------
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
