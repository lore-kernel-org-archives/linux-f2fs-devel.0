From: Ju Hyung Park <qkrwngud825@gmail.com>
Subject: Re: [PATCH 2/2] mkfs.f2fs: make the default extensions
 list much more sensical
Date: Wed, 17 Apr 2019 18:54:11 +0900
Message-ID: <CAD14+f2_dp8+KScRi4uyGG1KgQkqpdxGTZGvm5h3w++EYNvQnA@mail.gmail.com>
References: <20190416064355.29712-1-qkrwngud825@gmail.com>
 <20190416064355.29712-2-qkrwngud825@gmail.com>
 <c91943d3-8dbb-ca08-97c8-6e2d37392e70@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <qkrwngud825@gmail.com>) id 1hGhGx-00056f-3H
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 17 Apr 2019 09:54:31 +0000
Received: from mail-qk1-f194.google.com ([209.85.222.194])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1hGhGv-00Bk5j-Qc
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 17 Apr 2019 09:54:31 +0000
Received: by mail-qk1-f194.google.com with SMTP id 193so822580qki.6
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 17 Apr 2019 02:54:29 -0700 (PDT)
In-Reply-To: <c91943d3-8dbb-ca08-97c8-6e2d37392e70@huawei.com>
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
Cc: linux-f2fs-devel@lists.sourceforge.net

Hi Chao,

On Wed, Apr 17, 2019 at 6:41 PM Chao Yu <yuchao0@huawei.com> wrote:
> Actually, kernel will compare each character of extension in list with file's
> extension, rather than prefix, could you confirm that? :)

Just wrote a sample C program with namei.c's is_extension_exist() to
confirm this indeed works as intended.

Output:
Checking against "jp"
jpg: false
abc.jpg: true
abc.jpeg: true
abc.jpg.tmp: true
abc.jpeg.tmp: true
abc.jgp: false

Source:

#include <stdio.h>
#include <stddef.h>
#include <string.h>

static int is_extension_exist(const unsigned char *s, const char *sub)
{
    size_t slen = strlen(s);
    size_t sublen = strlen(sub);
    int i;

    /*
     * filename format of multimedia file should be defined as:
     * "filename + '.' + extension + (optional: '.' + temp extension)".
     */
    if (slen < sublen + 2)
        return 0;

    for (i = 1; i < slen - sublen; i++) {
        if (s[i] != '.')
            continue;
        if (!strncasecmp(s + i + 1, sub, sublen))
            return 1;
    }

    return 0;
}

static const char *list[] = {
    "jpg",
    "abc.jpg",
    "abc.jpeg",
    "abc.jpg.tmp",
    "abc.jpeg.tmp",
    "abc.jgp",
    NULL
};

#define CHECK "jp"

int main() {
    printf("Checking against \"%s\"\n", CHECK);

    for (int i = 0; list[i]; i++) {
        if (is_extension_exist(list[i], CHECK))
            printf("%s: true\n", list[i]);
        else
            printf("%s: false\n", list[i]);
    }
}
